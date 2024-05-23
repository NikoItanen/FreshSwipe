import 'package:flutter/material.dart';
import 'package:freshswipe/widgets/navbar.dart';

class UserPage extends StatefulWidget {
  const UserPage ({super.key});

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  switch (index) {
    case 0:
      Navigator.pushNamed(context, '/user');
      break;
    case 1:
      Navigator.pushNamed(context, '/menupage');
      break;
    case 2:
      Navigator.pushNamed(context, '/rewards');
      break;
    case 3:
      Navigator.pushNamed(context, '/cleaning');
      break;
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FreshSwipe",
      home: Scaffold(
        body: const Center(child: Text("This is the user page"),),
        bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      ),
    );
  }
}