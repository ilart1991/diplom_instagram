import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'gallery_page.dart';
import 'login_page.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {super.key,
      required this.uuid,
      required this.url,
      required this.title,
      required this.docId,
      required this.likes});
  final String uuid;
  final String url;
  final String title;
  final String docId;
  final List likes;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    List likes = widget.likes;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Подробнее"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.uuid,
              child: Image.network(
                widget.url,
                height: 200,
                width: 460,
                fit: BoxFit.fitWidth,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    debugPrint(widget.docId);
                    final currentPhotoRef =
                        db.collection("photos").doc(widget.docId);
                    if (!widget.likes.contains(userEmail)) {
                      await currentPhotoRef.update({
                        "likes": FieldValue.arrayUnion([userEmail]),
                      });
                      likes.add(userEmail);
                      setState(() {});
                    } else {
                      await currentPhotoRef.update({
                        "likes": FieldValue.arrayRemove([userEmail]),
                      });
                      likes.remove(userEmail);
                      setState(() {});
                      return;
                    }
                  },
                  icon: Icon(Icons.favorite,
                      color:
                          likes.contains(userEmail) ? Colors.red : Colors.grey),
                ),
                Text("Нравится: ${likes.length}")
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 12, right: 14),
              child: Text(
                widget.title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 12),
              child: likes.isNotEmpty
                  ? const Text(
                      "Нравится пользователям",
                      style: TextStyle(fontSize: 24),
                    )
                  : null,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: likes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(likes[index]),
                );
              },
            )
          ],
        ));
  }
}
