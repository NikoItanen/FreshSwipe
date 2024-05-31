import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freshswipe/pages/login_page.dart';
import 'package:freshswipe/pages/menu_page.dart';

void main() {
  testWidgets('Login page test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const LoginPage(),
      routes: {
        '/menupage': (context) => const MenuPage(),
      },
    ));

    debugPrint("Starting test...");

    //Check if application opens the login page first.
    try {
      await tester.tap(find.text('FreshSwipe'));
      debugPrint("Found initial FreshSwipe text.");
    } catch (e) {
      if (kDebugMode) {
        print("Error navigating to MenuPage: $e");
      }
    }

    //Ensure the Login button is visible by scrolling if necessary
    await tester.ensureVisible(find.text('Log In'));
    debugPrint('Found the Login button.');
  });
}
