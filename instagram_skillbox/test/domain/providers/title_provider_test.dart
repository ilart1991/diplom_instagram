import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_skillbox/domain/providers/title_provider.dart';
import 'package:instagram_skillbox/main.dart';
import 'package:localization/localization.dart';

void main() {
  testWidgets('title provider ...', (tester) async {
    runApp(const ProviderScope(child: MyApp()));

    final container = ProviderContainer();

    var titleGallery = container.read(titleProvider);
    expect(titleGallery, "gallery".i18n());
    container.read(titleProvider.notifier).profileTitle();
    var titleProfile = container.read(titleProvider);
    expect(titleProfile, "profile".i18n());
  });
}
