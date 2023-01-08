import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/localization.dart';

class TitleProvider extends StateNotifier<String> {
  TitleProvider() : super("gallery".i18n());

  void galleryTitle() => state = "gallery".i18n();
  void profileTitle() => state = "profile".i18n();
}

final titleProvider = StateNotifierProvider((ref) {
  return TitleProvider();
});
