import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_skillbox/domain/providers/add_photo_provider.dart';

void main() {
  test('add photo provider...t', () {
    final container = ProviderContainer();

    var photoStatusFalse = container.read(addPhotoProvider);
    expect(photoStatusFalse, false);
    container.read(addPhotoProvider.notifier).addIsActive();
    var photoStatusTrue = container.read(addPhotoProvider);
    expect(photoStatusTrue, true);
  });
}
