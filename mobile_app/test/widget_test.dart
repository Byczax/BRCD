// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/screens/main_page.dart';

void main() {
  testWidgets('Display login view and move user into another view',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    final loginButtonFinder = find.byKey(const Key("log-in-button"));
    final imageFinder = find.byKey(const Key("image-box"));
    // Verify that our counter starts at 0.
    expect(loginButtonFinder, findsOneWidget);
    expect(imageFinder, findsOneWidget);

    await tester.tap(loginButtonFinder);
  });
  testWidgets("Ensure that user can move between pages after log in",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoggedInView()));

    final bottomNavigationBar = find.byKey(const Key("navigation-bar"));
    expect(bottomNavigationBar, findsOneWidget);

    await tester.tap(find.byIcon(Icons.center_focus_strong_outlined));
    expect(find.text("Scanner"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings));
    expect(find.text("Settings"), findsWidgets);

    await tester.tap(find.byIcon(Icons.home));
    expect(find.text("Inventories"), findsOneWidget);
  });
}
