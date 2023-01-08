import 'package:flutter_riverpod/flutter_riverpod.dart';

class PagesProvider extends StateNotifier<int> {
  PagesProvider() : super(0);

  void galleryPage() => state = 0;
  void profilePage() => state = 1;
}

final pagesProvider = StateNotifierProvider((ref) {
  return PagesProvider();
});
