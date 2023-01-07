import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import '/presentation/pages/details_page.dart';
import '/presentation/pages/login_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

class GalleryPage extends StatelessWidget {
  GalleryPage({super.key});

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('photos')
      .orderBy("date", descending: true)
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

        return ListView(
          children: snapshot.data!.docs
              .map(
                (DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            uuid: data["url"],
                            url: data["url"],
                            title: data["title"],
                            docId: document.id,
                            likes: data["likes"],
                          ),
                        ),
                      );
                    },
                    child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 10,
                        margin: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: data["url"],
                              child: FadeInImage.assetNetwork(
                                  height: 200,
                                  width: 420,
                                  fit: BoxFit.fitWidth,
                                  placeholder: "assets/images/giphy.gif",
                                  image: data["url"]),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    debugPrint(document.id);
                                    final currentPhotoRef = db
                                        .collection("photos")
                                        .doc(document.id);
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
                                      return;
                                    }
                                  },
                                  icon: Icon(Icons.favorite,
                                      color: data["likes"].contains(userEmail)
                                          ? Colors.red
                                          : Colors.grey),
                                ),
                                Text(
                                  "${"like".i18n()}: ${data["likes"].length}",
                                  maxLines: 1,
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, bottom: 12),
                              child: Text(data["title"],
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
                            )
                          ],
                        )),
                  );
                },
              )
              .toList()
              .cast(),
        );
      },
    );
  }
}
