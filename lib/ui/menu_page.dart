import 'package:flutter/material.dart';
import 'package:freshswipe/services/auth.dart';
import 'package:freshswipe/controllers/user_controller.dart';
import 'package:freshswipe/ui/widgets/global/navbar.dart';
import 'package:freshswipe/ui/widgets/global/level_star.dart';

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


    // Switch to selected page:
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        //Add page's content here:(
          child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              widthFactor: 0.9,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LevelStar(),
                    const SizedBox(height: 20),
                    _buildWelcomeContainer(context),
                  ],
                ),
              ),)
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
Widget _buildWelcomeContainer(BuildContext context) {
  double containerHeight = MediaQuery.of(context).size.height * 0.1;

  return FutureBuilder<List<dynamic>>(
      future: Future.wait([
        Auth().getCurrentUserId().then((userId) => UserController.fetchAndHandleDayStreak(userId!)),
        Auth().getCurrentUserId().then((userId) => UserController.fetchUserFirstName(userId!)),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError || !snapshot.hasData) {
            return const Text('Error fetching user data');
          } else {
            int currentStreak = snapshot.data![0] as int;
            String firstName = snapshot.data![1] as String;
            return Container(
              width: double.infinity,
              height: containerHeight,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 3, 72, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Welcome Back $firstName!',
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.local_fire_department, size: 42, color: Color.fromRGBO(226, 88, 34, 1)),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      '$currentStreak',
                      style: const TextStyle(color: Color.fromRGBO(226, 88, 34, 1), fontSize: 34),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          );
}
