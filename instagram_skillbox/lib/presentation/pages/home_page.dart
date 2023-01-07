import 'package:flutter/material.dart';
import 'package:instagram_skillbox/domain/firebase_func.dart';
import 'package:instagram_skillbox/presentation/pages/gallery_page.dart';

import 'package:instagram_skillbox/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: "Галерея"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
  ];
  int bottomIndex = 0;
  bool addIsActive = false;
  String title = "Галерея";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
      body: bottomIndex == 0 ? GalleryPage() : const ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomIndex,
          onTap: (value) => setState(() {
                bottomIndex = value;
                if (value == 0) {
                  title = "Галерея";
                  addIsActive = false;
                } else {
                  title = "Профиль";
                  addIsActive = true;
                }
              }),
          items: bottomNavBarItems),
    );
  }
}
