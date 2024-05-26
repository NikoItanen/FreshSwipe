import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/widgets/global/cleanliness_star.dart';
import 'package:freshswipe/widgets/global/navbar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

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
          child: SingleChildScrollView(
              child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Padding(
              padding: const EdgeInsets.only(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TotalCleanlinessStar(),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 450),
                    child: Container(
                    width: double.infinity,
                    height: 605,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 3, 72, 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(padding: EdgeInsets.only(left: 20, top: 20, bottom: 20), child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Username: ", style: TextStyle(color: Colors.white)),
                              SizedBox(height: 8,),
                              Text("User Created: ", style: TextStyle(color: Colors.white)),
                              SizedBox(height: 8,),
                              Text("Cleaning Activities: ", style: TextStyle(color: Colors.white))
                              ],
                              )
                          )
                          ),
                        SizedBox(
                          width: 410,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor:
                                    Colors.white),
                            onPressed: () {
                              if (kDebugMode) {
                                print('Account Settings pressed!');
                              }
                            },
                            child: const Text(
                              "Account Settings",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 410,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor:
                                    const Color.fromRGBO(167, 85, 85, 1)),
                            onPressed: () {
                              if (kDebugMode) {
                                print('Logout button pressed!');
                              }
                            },
                            child: const Text(
                              "Log Out",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,)
                      ],
                    )),
                  ))
                ],
              ),
            ),
          )),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      ),
    );
  }
}
