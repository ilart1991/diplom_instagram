import 'package:flutter_riverpod/flutter_riverpod.dart';

final registeredProvider = StateNotifierProvider((ref) {
  return RegisteredProvider();
});

class RegisteredProvider extends StateNotifier<bool> {
  RegisteredProvider() : super(true);

  void isReg() => state = true;
  void notReg() => state = false;
}
