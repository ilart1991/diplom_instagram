// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../presentation/pages/gallery_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/widgets/login_reg_form.dart';

final storageRef = FirebaseStorage.instance.ref();
TextEditingController descController = TextEditingController();

void login(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginController.text, password: passwordController.text);
    userEmail = loginController.text;
    _goHome(context);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      debugPrint('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      debugPrint('Wrong password provided for that user.');
    }
  }
}

void _goHome(BuildContext context) {
  Navigator.pushReplacementNamed(context, "/home");
}

void registration() async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: loginController.text,
      password: passwordController.text,
    );

    var db = FirebaseFirestore.instance;
    await db.collection("users").add({
      "email": loginController.text,
      "name": "",
      "avatar": "",
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      debugPrint('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      debugPrint('The account already exists for that email.');
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

void addPhoto(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg'],
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    final photoRef = storageRef
        .child("photos/${Random().nextInt(9999)}${result.names.toString()}");

    try {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.file(file),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                      hintText: "desc".i18n(), labelText: "desc".i18n()),
                ),
                MaterialButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text("upload".i18n()),
                  onPressed: () async {
                    photoRef
                        .putFile(file)
                        .snapshotEvents
                        .listen((taskSnapshot) async {
                      switch (taskSnapshot.state) {
                        case TaskState.success:
                          String url = await photoRef.getDownloadURL();
                          db.collection("photos").add({
                            "title": descController.text,
                            "url": url,
                            "author": userEmail,
                            "likes": [],
                            "date": DateTime.now()
                          });
                          descController.text = "";
                          Navigator.pop(context);
                          break;
                        case TaskState.paused:
                          break;
                        case TaskState.running:
                          break;
                        case TaskState.canceled:
                          break;
                        case TaskState.error:
                          break;
                      }
                    });
                  },
                )
              ],
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
