import 'package:flutter/material.dart';
import 'package:freshswipe/widgets/global/navbar.dart';

class RewardPage extends StatefulWidget {
  const RewardPage ({super.key});

  @override
  State<RewardPage> createState() => _RewardPage();
}

class _RewardPage extends State<RewardPage> {
int _selectedIndex = 2;

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
      Navigator.pushNamed(context, '/rooms');
      break;
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FreshSwipe",
      home: Scaffold(
        body: const Center(child: Text("This is the rewards page"),),
        bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      ),
    );
  }
}