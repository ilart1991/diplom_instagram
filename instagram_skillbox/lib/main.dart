import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/pages/home_page.dart';

import 'presentation/pages/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'presentation/pages/profile_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
  initFirebase();
}

void initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const LoginPage(title: 'FlutterGram'),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) =>
            const LoginPage(title: "FlutterGram"),
        '/home': (BuildContext context) => HomePage(),
        '/profile': (BuildContext context) => const ProfilePage(),
      },
    );
  }
}
