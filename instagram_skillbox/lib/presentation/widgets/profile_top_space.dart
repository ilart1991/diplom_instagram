import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../pages/gallery_page.dart';
import '../pages/login_page.dart';

class ProfileTopSpace extends StatelessWidget {
  ProfileTopSpace({super.key});

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where("email", isEqualTo: userEmail)
      .snapshots();
  final TextEditingController nameController = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Неизвестная ошибка'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          nameController.text = snapshot.data?.docs[0]["name"];
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg'],
                        );

                        if (result != null) {
                          File file = File(result.files.single.path!);
                          final avatarRef = storageRef.child(
                              "avatars/$userEmail/${Random().nextInt(9999)}");

                          try {
                            await avatarRef.putFile(file);
                            String url = await avatarRef.getDownloadURL();
                            db
                                .collection("users")
                                .doc(snapshot.data?.docs[0].id)
                                .update({
                              "avatar": url,
                            });
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        }
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(snapshot.data?.docs[0]["avatar"]),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                labelText: "Имя пользователя",
                                hintText: "Имя пользователя"),
                          ),
                          MaterialButton(
                            minWidth: 240,
                            onPressed: () {
                              db
                                  .collection("users")
                                  .doc(snapshot.data?.docs[0].id)
                                  .update({
                                "name": nameController.text,
                              });
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: const Text("Сохранить"),
                          )
                        ],
                      ))
                ],
              ),
              MaterialButton(
                color: Colors.red.shade300,
                minWidth: 420,
                textColor: Colors.white,
                child: const Text("Выйти из аккаунта"),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false),
              )
            ],
          );
        });
  }
}
