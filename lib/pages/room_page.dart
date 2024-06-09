import 'package:flutter/material.dart';
import 'package:freshswipe/widgets/global/level_star.dart';
import 'package:freshswipe/widgets/global/navbar.dart';
import 'package:freshswipe/widgets/roomwidgets/dialog_widgets/room_dialog.dart';
import 'package:freshswipe/widgets/roomwidgets/room_scroll_view.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPage();
}

class _RoomsPage extends State<RoomsPage> {
  int _selectedIndex = 3;



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
      backgroundColor: Colors.white,
      body: Center(
          child: FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.9,
        heightFactor: 0.9,
        child: Column(
          children: [
            const LevelStar(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 3, 72, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: const Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Your Housing",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                    Spacer(),
                    RoomDialog()
                  ],
                ),
              ),
            ),
                const Expanded(
                    child: RoomScrollView(
                    ),
                  )
          ],
        ),
      )),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
