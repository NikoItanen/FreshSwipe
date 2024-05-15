import 'package:flutter/material.dart';
import 'package:freshswipe/menu_page.dart';
import 'package:freshswipe/login_page.dart';

void main() {
  runApp(const FreshSwipe());
}

class FreshSwipe extends StatelessWidget {
  const FreshSwipe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.green),
        home: const LoginPage(),
        routes: {
          '/menupage': (context) => const MenuPage(),
          '/loginpage': (context) => const LoginPage()
        });
  }
}
