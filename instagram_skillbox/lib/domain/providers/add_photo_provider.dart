import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPhotoProvider extends StateNotifier<bool> {
  AddPhotoProvider() : super(false);

  void addIsActive() => state = true;
  void addIsDisabled() => state = false;
}

final addPhotoProvider = StateNotifierProvider((ref) {
  return AddPhotoProvider();
});
