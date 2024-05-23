import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'login_page.dart';
import 'cleaning_page.dart';
import 'user_page.dart';
import 'rewards_page.dart';

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
          '/loginpage': (context) => const LoginPage(),
          '/user': (context) => const UserPage(),
          '/rewards': (context) => const RewardPage(),
          '/cleaning': (context) => const CleaningPage()
        });
  }
}
