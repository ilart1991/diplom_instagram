import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_skillbox/domain/providers/registered_provider.dart';

void main() {
  test('registered provider ...', () {
    final container = ProviderContainer();

    var regStatusFalse = container.read(registeredProvider);
    expect(regStatusFalse, true);
    container.read(registeredProvider.notifier).notReg();
    var regStatusTrue = container.read(registeredProvider);
    expect(regStatusTrue, false);
  });
}
