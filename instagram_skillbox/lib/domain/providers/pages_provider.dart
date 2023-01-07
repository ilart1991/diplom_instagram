import 'package:flutter_riverpod/flutter_riverpod.dart';

class Pages extends StateNotifier<int> {
  Pages() : super(0);

  void galleryPage() => state = 0;
  void profilePage() => state = 1;
}

final pagesProvider = StateNotifierProvider((ref) {
  return Pages();
});
