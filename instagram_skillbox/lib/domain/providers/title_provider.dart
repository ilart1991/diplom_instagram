import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';

class Title extends StateNotifier<String> {
  Title() : super("gallery".i18n());

  void galleryTitle() => state = "gallery".i18n();
  void profileTitle() => state = "profile".i18n();
}

final titleProvider = StateNotifierProvider((ref) {
  return Title();
});
