import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'login_page.dart';
import 'room_page.dart';
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
        // Title for the application
        title: "FreshSwipe",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        //Define the starting page.
        home: const LoginPage(),
        //Specify all routes to the created pages.
        routes: {
          '/menupage': (context) => const MenuPage(),
          '/loginpage': (context) => const LoginPage(),
          '/user': (context) => const UserPage(),
          '/rewards': (context) => const RewardPage(),
          '/rooms': (context) => const RoomsPage()
        });
  }
}
