import 'package:flutter/material.dart';

//This class takes responsibility for the functionality and appearance of the navigation bar at the bottom of the screen. 

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
    super.key,
  });

  //Navigation bar content here below:
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
              //User page item;
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                  label: "User"),
              //Home page item
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                  label: "Home"),
              //Rewards page item
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events),
                  backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                  label: "Rewards"),
              //Cleaning page item
              BottomNavigationBarItem(
                  icon: Icon(Icons.cleaning_services),
                  backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                  label: "Cleaning")
    ]);
  }
}