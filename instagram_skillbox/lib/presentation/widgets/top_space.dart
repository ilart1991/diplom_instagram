import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import 'package:http/http.dart' as http;

class TopSpace extends StatefulWidget {
  const TopSpace({super.key});

  @override
  State<TopSpace> createState() => _TopSpaceState();
}

class _TopSpaceState extends State<TopSpace> {
  TextEditingController nameController = TextEditingController();
  String avatarUrl =
      "https://firebasestorage.googleapis.com/v0/b/instagramskillbox.appspot.com/o/avatars%2F$userEmail%2Favatar.jpg?alt=media";
  final storageRef = FirebaseStorage.instance.ref();

  getAvatarStatus() async {
    int statusCode = 0;
    await http.get(Uri.parse(avatarUrl)).then((value) {
      return statusCode = value.statusCode;
    });

    return statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg'],
                );

                if (result != null) {
                  File file = File(result.files.single.path!);
                  final avatarRef =
                      storageRef.child("avatars/$userEmail/avatar.jpg");

                  try {
                    await avatarRef.putFile(file);
                    setState(() {});
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                }
              },
              child: FutureBuilder(
                future: getAvatarStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data == 200) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(avatarUrl),
                    );
                  } else {
                    return const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue,
                    );
                  }
                },
              ),
            )),
        Expanded(
            flex: 3,
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(hintText: "Имя пользователя"),
                ),
                MaterialButton(
                  minWidth: 240,
                  onPressed: () {},
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: const Text("Сохранить"),
                )
              ],
            ))
      ],
    );
  }
}
