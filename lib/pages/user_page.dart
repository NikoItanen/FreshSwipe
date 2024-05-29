import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/auth.dart';
import 'package:freshswipe/widgets/global/cleanliness_star.dart';
import 'package:freshswipe/widgets/global/navbar.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  int _selectedIndex = 0;
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

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
    double containerHeight = MediaQuery.of(context).size.height * 0.75;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: SingleChildScrollView(
            child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // User Page content here below:
              children: [
                const TotalCleanlinessStar(),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: containerHeight,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 3, 72, 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Column(
                    children: [
                      _userUid(),
                      _userInfo(context),
                      _userPageButton(context, "Account Settings", Colors.white,
                          () {
                        if (kDebugMode) {
                          print('Account settings button pressed!');
                        }
                      }),
                      const Spacer(),
                      _userPageButton(context, "Log Out",
                          const Color.fromRGBO(167, 85, 85, 1), () {
                        signOut().then((_) {
                          Navigator.pushNamedAndRemoveUntil(context, '/loginpage', (route) => false);
                        });
                      }),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  )),
                )
              ],
            ),
          ),
        )),
      ),
      //The navigation bar here:
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}

//Information about user's account.
//TODO: Link this to the user model.
Widget _userInfo(BuildContext context) {
  return const Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Username:", style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 8,
              ),
              Text("User Created: ", style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 8,
              ),
              Text("Cleaning Activities: ",
                  style: TextStyle(color: Colors.white))
            ],
          )));
}

//Custom Widget for the User Page buttons.
Widget _userPageButton(BuildContext context, String buttonText, Color color,
    VoidCallback onPressed) {
  return SizedBox(
      width: 410,
      height: 50,
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: color),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 14),
        ),
      ));
}
