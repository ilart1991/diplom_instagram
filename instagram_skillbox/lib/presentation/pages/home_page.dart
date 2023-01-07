import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_skillbox/domain/providers/add_photo_provider.dart';
import 'package:instagram_skillbox/domain/providers/pages_provider.dart';
import 'package:instagram_skillbox/domain/providers/title_provider.dart';
import '/domain/firebase_func.dart';
import '/presentation/pages/gallery_page.dart';

import '/presentation/pages/profile_page.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: "Галерея"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
  ];

  @override
  Widget build(BuildContext context, ref) {
    final currentPage = ref.watch(pagesProvider) as int;
    final currentTitle = ref.watch(titleProvider) as String;
    final addIsActive = ref.watch(addPhotoProvider) as bool;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentTitle),
        centerTitle: true,
        actions: [
          Visibility(
              visible: addIsActive,
              child: IconButton(
                  onPressed: () {
                    addPhoto(context);
                  },
                  icon: const Icon(Icons.add)))
        ],
      ),
      body: currentPage == 0 ? GalleryPage() : const ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (value) {
            if (value != 0) {
              ref.read(pagesProvider.notifier).profilePage();
              ref.read(titleProvider.notifier).profileTitle();
              ref.read(addPhotoProvider.notifier).addIsActive();
            } else {
              ref.read(pagesProvider.notifier).galleryPage();
              ref.read(titleProvider.notifier).galleryTitle();
              ref.read(addPhotoProvider.notifier).addIsDisabled();
            }
          },
          items: bottomNavBarItems),
    );
  }
}
