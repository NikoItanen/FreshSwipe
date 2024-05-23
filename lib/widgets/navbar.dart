import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                  label: "User"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events),
                  backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                  label: "Achievements"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.cleaning_services),
                  backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                  label: "Cleaning")
    ]);
  }
}