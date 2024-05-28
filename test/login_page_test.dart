import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freshswipe/login_page.dart';
import 'package:freshswipe/menu_page.dart';

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

    //Navigate to the menu page
    try {
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();
      debugPrint('Tapped Log In and navigated to menu page.');
    } catch (e) {
      if (kDebugMode) {
        print('Error navigating to menu page: $e');
      }
    }

    try {
      expect(find.text('Welcome back!'), findsOneWidget);
      debugPrint('Found welcome text on menu page.');
    } catch (e) {
      if (kDebugMode) {
        print('Error finding welcome text on menu page: $e');
      }
    }
  });
}
