import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPhoto extends StateNotifier<bool> {
  AddPhoto() : super(false);

  void addIsActive() => state = true;
  void addIsDisabled() => state = false;
}

final addPhotoProvider = StateNotifierProvider((ref) {
  return AddPhoto();
});
