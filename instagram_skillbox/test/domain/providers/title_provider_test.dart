import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_skillbox/domain/providers/title_provider.dart';

void main() {
  test('title provider ...', () {
    final container = ProviderContainer();

    var titleGallery = container.read(titleProvider);
    expect(titleGallery, "Галерея");
    container.read(titleProvider.notifier).profileTitle();
    var titleProfile = container.read(titleProvider);
    expect(titleProfile, "Профиль");
  });
}
