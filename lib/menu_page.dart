import 'package:flutter/material.dart';
import 'package:freshswipe/widgets/global/navbar.dart';
import 'package:freshswipe/widgets/global/cleanliness_star.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/user');
        break;
      case 1:
        Navigator.pushNamed(context, '/home');
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        //Add page's content here:
        child: SingleChildScrollView(
          child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              widthFactor: 0.9,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TotalCleanlinessStar(),
                    const SizedBox(height: 20),
                    _buildWelcomeContainer(context)
                  ],
                ),
              )),
        ),
      ),
      //The navigation bar here:
      bottomNavigationBar: CustomBottomNavigationBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

//Menu page's welcome container built here:
//TODO: Link this to the user model to have streak and name display.
Widget _buildWelcomeContainer(BuildContext context) {
  double containerHeight = MediaQuery.of(context).size.height * 0.1;

  return Container(
    width: double.infinity,
    height: containerHeight,
    decoration: BoxDecoration(
      color: const Color.fromRGBO(0, 3, 72, 1),
      borderRadius: BorderRadius.circular(20),
    ),
    //The content inside the container here:
    child: const Row(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Welcome back Niko!',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      Spacer(),
      Icon(Icons.local_fire_department,
          size: 42, color: Color.fromRGBO(226, 88, 34, 1)),
      Padding(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            '137',
            style:
                TextStyle(color: Color.fromRGBO(226, 88, 34, 1), fontSize: 34),
          ))
    ]),
  );
}
