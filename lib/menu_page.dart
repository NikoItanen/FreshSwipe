import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
                child: TextButton(
      child: const Text('Back to the login page!'),
      onPressed: () {
        Navigator.pushNamed(context, '/loginpage');
      },
    ))));
  }
}
