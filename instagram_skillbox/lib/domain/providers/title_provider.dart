import 'package:flutter_riverpod/flutter_riverpod.dart';

class Title extends StateNotifier<String> {
  Title() : super("Галерея");

  void galleryTitle() => state = "Галерея";
  void profileTitle() => state = "Профиль";
}

final titleProvider = StateNotifierProvider((ref) {
  return Title();
});
