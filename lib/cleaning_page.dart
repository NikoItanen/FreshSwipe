import 'package:flutter/material.dart';
import 'package:freshswipe/widgets/navbar.dart';

class CleaningPage extends StatefulWidget {
  const CleaningPage ({super.key});

  @override
  State<CleaningPage> createState() => _CleaningPage();
}

class _CleaningPage extends State<CleaningPage> {
int _selectedIndex = 3;

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
        body: const Center(child: Text("This is the cleaning page"),),
        bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      ),
    );
  }
}