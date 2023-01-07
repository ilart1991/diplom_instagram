import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_skillbox/domain/providers/details_provider.dart';

void main() {
  test('details provider ...', () {
    final container = ProviderContainer();

    var details = container.read(detailsProvider);
    expect(details, []);
  });
}
