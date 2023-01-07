import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_skillbox/domain/providers/pages_provider.dart';

void main() {
  test('pages provider ...', () {
    final container = ProviderContainer();

    var intZero = container.read(pagesProvider);
    expect(intZero, 0);
    container.read(pagesProvider.notifier).profilePage();
    var intOne = container.read(pagesProvider);
    expect(intOne, 1);
  });
}
