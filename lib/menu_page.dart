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
    return MaterialApp(
        title: "FreshSwipe",
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Center(
            //Content over here:
            child: SingleChildScrollView(
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 450),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TotalCleanlinessStar(),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        height: 85,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 3, 72, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Welcome back!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      TextButton(
                        child: const Text('Back to the login page!'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/loginpage');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Navigation bar implementation here:
          bottomNavigationBar: CustomBottomNavigationBar(
            onItemTapped: _onItemTapped,
            selectedIndex: _selectedIndex,),
        ));
  }
}
