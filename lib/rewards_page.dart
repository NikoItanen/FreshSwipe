import 'package:flutter/material.dart';
import 'package:freshswipe/widgets/global/cleanliness_star.dart';
import 'package:freshswipe/widgets/global/navbar.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

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
        backgroundColor: Colors.white,
        body: Center(
          child: FractionallySizedBox(
              alignment: Alignment.center,
              widthFactor: 0.9,
              heightFactor: 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const TotalCleanlinessStar(),
                  const SizedBox(height: 20),
                  Flexible(
                    child: Stack(children: [
                      Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 3, 72, 1),
                              borderRadius: BorderRadius.circular(20))),
                      const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Rewards',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            )
                          ]))
                    ]),
                  )
                ],
              )),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
      ),
    );
  }
}
