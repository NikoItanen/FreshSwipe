import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FreshSwipe",
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
            body: Center(
              //Content over here:
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Container(
                      width: 350,
                      height: 85,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Welcome back [USER]!')
                      ) 
                    ),
                    TextButton(
                    child: const Text('Back to the login page!'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/loginpage');
                    },
                  )
                ]
              )
              ),
              // Navigation bar implementation here:
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: 1,
                items: const [

                  BottomNavigationBarItem(
                    icon: Icon (Icons.person), 
                    backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                    label: "User"
                    ),

                  BottomNavigationBarItem(
                    icon: Icon (Icons.home), 
                    backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                    label: "Home",
                    ),

                  BottomNavigationBarItem(
                    icon: Icon (Icons.emoji_events),
                    backgroundColor: Color.fromRGBO(0, 3, 72, 1),
                    label: "Achievements"
                    )
                    ],
                ),
          )
      );
  }
}
