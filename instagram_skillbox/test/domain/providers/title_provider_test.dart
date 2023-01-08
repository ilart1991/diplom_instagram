import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_skillbox/domain/providers/title_provider.dart';
import 'package:instagram_skillbox/main.dart';
import 'package:instagram_skillbox/presentation/pages/home_page.dart';
import 'package:instagram_skillbox/presentation/pages/login_page.dart';

import 'package:localization/localization.dart';

void main() {
  testWidgets('title provider ...', (tester) async {
    runApp(const ProviderScope(child: MyApp()));

    await tester.pumpWidget(const MaterialApp(
      home: ProviderScope(child: LoginPage(title: "FlutterGram")),
    ));
    expect(find.text("FlutterGram"), findsOneWidget);
    expect(find.text("E-mail"), findsWidgets);
    expect(find.text("password".i18n()), findsWidgets);
    final container = ProviderContainer();

    var titleGallery = container.read(titleProvider);
    expect(titleGallery, "gallery".i18n());
    container.read(titleProvider.notifier).profileTitle();
    var titleProfile = container.read(titleProvider);
    expect(titleProfile, "profile".i18n());
  });
}
