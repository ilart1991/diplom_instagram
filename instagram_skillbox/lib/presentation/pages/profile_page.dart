import 'package:flutter/material.dart';

import 'package:instagram_skillbox/presentation/widgets/profile_top_space.dart';
import 'package:instagram_skillbox/presentation/widgets/profile_photos.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ProfileTopSpace(),
            ProfilePhotos(),
          ],
        ),
      ),
    );
  }
}
