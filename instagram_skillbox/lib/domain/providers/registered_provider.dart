import 'package:flutter_riverpod/flutter_riverpod.dart';

final registeredProvider = StateNotifierProvider((ref) {
  return Registered();
});

class Registered extends StateNotifier<bool> {
  Registered() : super(true);

  void isReg() => state = true;
  void notReg() => state = false;
}
