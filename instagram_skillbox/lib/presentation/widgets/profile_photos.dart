import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/details_page.dart';
import '../pages/gallery_page.dart';
import '../pages/login_page.dart';

class ProfilePhotos extends StatelessWidget {
  ProfilePhotos({super.key});

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('photos')
      .orderBy("date", descending: true)
      .where("author", isEqualTo: userEmail)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {}

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            children: snapshot.data!.docs
                .map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            uuid: data["url"],
                            url: data["url"],
                            title: data["title"],
                            docId: document.id,
                            likes: data["likes"],
                          ),
                        ),
                      ),
                      onLongPress: () {
                        db.collection("photos").doc(document.id).delete();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: Image.network(
                              data["url"],
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Stack(children: [
                              IconButton(
                                onPressed: () {
                                  final currentPhotoRef =
                                      db.collection("photos").doc(document.id);
                                  if (!data["likes"].contains(userEmail)) {
                                    currentPhotoRef.update({
                                      "likes":
                                          FieldValue.arrayUnion([userEmail]),
                                    });
                                  } else {
                                    currentPhotoRef.update({
                                      "likes":
                                          FieldValue.arrayRemove([userEmail]),
                                    });
                                  }
                                },
                                icon: Icon(Icons.favorite,
                                    color: data["likes"].contains(userEmail)
                                        ? Colors.red
                                        : Colors.grey),
                              ),
                              Positioned(
                                  top: 15,
                                  left: 20,
                                  child: Text(
                                    data["likes"].length.toString(),
                                    maxLines: 1,
                                    style: const TextStyle(color: Colors.white),
                                  ))
                            ]),
                          ),
                        ],
                      ),
                    );
                  },
                )
                .toList()
                .cast(),
          ),
        );
      },
    );
  }
}
