import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freshswipe/pages/login_page.dart';
import 'package:freshswipe/pages/menu_page.dart';

void main() {
  testWidgets('Initial page load test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const LoginPage(),
      routes: {
        '/menupage': (context) => const MenuPage(),
      },
    ));

    debugPrint("Starting test page load test...");

    //Check if application opens the login page first.
    await tester.tap(find.text('FreshSwipe'));
    debugPrint("Found initial FreshSwipe text.");

    //Ensure the Login button is visible by scrolling if necessary
    await tester.ensureVisible(find.text('Log In'));
    debugPrint('Found the Login button.');

    //Ensure the Sign Up button is visible by scrolling if necessary
    await tester.ensureVisible(find.text('Create a new account!'));
    debugPrint('Found the sign up button!');
  });

  testWidgets('Email and password input test', (WidgetTester tester) async {
    // Build required widgets
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    // Wait for the animations
    await tester.pumpAndSettle();

    // Find email and password fields
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));

    // Ensure the email and password fields are visible by scrolling if necessary
    await tester.ensureVisible(emailField);
    await tester.ensureVisible(passwordField);

    // Check if all fields are visible
    expect(emailField, findsOneWidget);
    expect(passwordField, findsOneWidget);

    // Insert text to fields
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'testpassword');

    // Ensure that all written texts are showing up.
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('testpassword'), findsOneWidget);

    // Wait for all operations are done.
    await tester.pumpAndSettle();

    debugPrint('Email and password field test completed!');
  });

  testWidgets('Password visibility toggle test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Find password field
    final passwordField = find.byKey(const Key('passwordField'));

    //Ensure that password field is visible.
    await tester.ensureVisible(passwordField);
    expect(passwordField, findsOneWidget);

    // Enter password
    await tester.enterText(passwordField, 'testpassword');

    // Verify that the password's input text is not visible
    final passwordObscured = find.descendant(
      of: passwordField,
      matching: find.text('testpassword'),
    );
    expect(passwordObscured, findsOneWidget);

    // Tap on the visibility toggle button
    final visibilityToggle = find.byKey(const Key('passwordToggleIcon'));
    await tester.tap(visibilityToggle);
    await tester.pump();

    // Verify that the password is now visible
    expect(find.text('testpassword'), findsOneWidget);

    debugPrint('Password vibility toggle test completed!');
  });

testWidgets('Switch between login and signup test', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: LoginPage()));

  // Ensure the "Create a new account!" button is visible and tap it to switch to the signup view
  final createAccountButton = find.byKey(const Key('createAccountButton'));
  await tester.ensureVisible(createAccountButton);
  await tester.tap(createAccountButton);
  await tester.pumpAndSettle();

  // Verify that the signup button is found
  expect(find.byKey(const Key('signUpButton')), findsOneWidget);

  // Ensure the "I already have an account!" button is visible and tap it to switch back to the login view
  final alreadyHaveAccountButton = find.byKey(const Key('alreadyHaveAccountButton'));
  await tester.ensureVisible(alreadyHaveAccountButton);
  await tester.tap(alreadyHaveAccountButton);
  await tester.pumpAndSettle();

  // Verify that the login button is found
  expect(find.byKey(const Key('loginButton')), findsOneWidget);

      debugPrint('Switch between login and sign up pages is working.');
});



testWidgets('Error message display test', (WidgetTester tester) async {
  await tester.pumpWidget(const MaterialApp(home: LoginPage()));

  // Switch to the signup view
  // Ensure the "Create a new account!" button is visible and tap it to switch to the signup view
  final createAccountButton = find.byKey(const Key('createAccountButton'));
  await tester.ensureVisible(createAccountButton);
  await tester.tap(createAccountButton);
  await tester.pumpAndSettle();

  final emailField = find.byKey(const Key('emailField'));
  final firstNameField = find.byKey(const Key('firstNameField'));
  final lastNameField = find.byKey(const Key('lastNameField'));
  final passwordField = find.byKey(const Key('passwordField'));
  final verifyPasswordField = find.byKey(const Key('verifyPasswordField'));

  await tester.ensureVisible(emailField);
  await tester.ensureVisible(firstNameField);
  await tester.ensureVisible(lastNameField);
  await tester.ensureVisible(passwordField);
  await tester.ensureVisible(verifyPasswordField);

  await tester.pumpAndSettle();


  // Enter values into the text fields
  await tester.enterText(emailField, 'testpassword');
  await tester.enterText(firstNameField, 'Test');
  await tester.enterText(lastNameField, 'Guy');
  await tester.enterText(passwordField, 'testpassword');
  await tester.enterText(verifyPasswordField, 'wrongpassword');

  // Tap the "Sign Up" button
  await tester.tap(find.text('Sign Up'));
  await tester.pump();

  // Verify that the error message is displayed
  expect(find.text('Passwords do not match'), findsOneWidget);

  debugPrint('Error message is showing up correctly.');
});

}
