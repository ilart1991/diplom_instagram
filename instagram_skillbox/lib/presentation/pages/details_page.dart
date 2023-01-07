import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/details_provider.dart';
import 'gallery_page.dart';
import 'login_page.dart';

class DetailsPage extends ConsumerWidget {
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
  Widget build(BuildContext context, ref) {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ref.read(listProvider.notifier).setData(likes));
    final likesArray = ref.watch(listProvider);
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
              tag: uuid,
              child: Image.network(
                url,
                height: 200,
                width: 460,
                fit: BoxFit.fitWidth,
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    debugPrint(docId);
                    final currentPhotoRef = db.collection("photos").doc(docId);
                    if (!likesArray.contains(userEmail)) {
                      await currentPhotoRef.update({
                        "likes": FieldValue.arrayUnion([userEmail]),
                      });
                      ref.read(listProvider.notifier).addItem();
                      // setState(() {});
                    } else {
                      await currentPhotoRef.update({
                        "likes": FieldValue.arrayRemove([userEmail]),
                      });
                      ref.read(listProvider.notifier).removeItem();
                      // setState(() {});
                      return;
                    }
                  },
                  icon: Icon(Icons.favorite,
                      color: likesArray.contains(userEmail)
                          ? Colors.red
                          : Colors.grey),
                ),
                Text("Нравится: ${likesArray.length}")
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 12, right: 14),
              child: Text(
                title,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 12),
              child: likesArray.isNotEmpty
                  ? const Text(
                      "Нравится пользователям",
                      style: TextStyle(fontSize: 24),
                    )
                  : null,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: likesArray.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(likesArray[index]),
                );
              },
            )
          ],
        ));
  }
}
