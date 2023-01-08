import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:instagram_skillbox/presentation/pages/login_page.dart';
import 'package:localization/localization.dart';

void main() {
  testWidgets('login page ...', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ProviderScope(child: LoginPage(title: "FlutterGram")),
    ));
    expect(find.text("FlutterGram"), findsOneWidget);
    expect(find.text("E-mail"), findsOneWidget);
    expect(find.text("password".i18n()), findsOneWidget);

    await tester.enterText(find.byKey(const Key("e-mail")), "ilart1991@ya.ru");
    expect(find.text("ilart1991@ya.ru"), findsOneWidget);
    await tester.enterText(find.byKey(const Key("password")), "12345");
    expect(find.text("12345"), findsOneWidget);
  });
}
