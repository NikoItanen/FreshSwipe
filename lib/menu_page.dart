import 'package:flutter/material.dart';
import 'package:freshswipe/widgets/navbar.dart';

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
      Navigator.pushNamed(context, '/cleaning');
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
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 50, bottom: 50),
                          child: SizedBox(
                              width: 65,
                              height: 65,
                              child: Stack(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 65,
                                    color: Colors.orange,
                                    shadows: [
                                      Shadow(
                                          color: Color.fromARGB(255, 36, 35, 0),
                                          blurRadius: 3,
                                          offset: Offset(0, 1))
                                    ],
                                  ),
                                  Center(child: Text("X"))
                                ],
                              )),
                        ),
                      ),
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
                            'Welcome back [USER]!',
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
