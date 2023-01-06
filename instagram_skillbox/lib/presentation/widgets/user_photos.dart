import 'package:flutter/material.dart';

import '../pages/gallery_page.dart';
import '../pages/login_page.dart';

class UserPhotos extends StatefulWidget {
  const UserPhotos({super.key});

  @override
  State<UserPhotos> createState() => _UserPhotosState();
}

class _UserPhotosState extends State<UserPhotos> {
  List<Map> myPhotos = [];

  Future<List> _getData() async {
    await db
        .collection("photos")
        .where("author", isEqualTo: userEmail)
        .get()
        .then((event) {
      myPhotos.clear();
      for (var doc in event.docs) {
        myPhotos.add(doc.data());
      }
    });

    return myPhotos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: myPhotos.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        child: Image.network(
                      myPhotos[index]["url"],
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                    )),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
                    ),
                    Positioned(
                        top: 15,
                        left: 20,
                        child: Text(
                          myPhotos[index]["likes"].length.toString(),
                          style: const TextStyle(color: Colors.white),
                        ))
                  ],
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
