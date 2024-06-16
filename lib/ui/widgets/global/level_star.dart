import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/controllers/user_controller.dart';

//This class takes responsibility for the functionality and appearance of the cleanliness star. 

class LevelStar extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  LevelStar({super.key});


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 50, left: 50),
        child: SizedBox(
          width: 65,
          height: 65,
          child: Stack(
            children: <Widget>[
              const Icon(
                Icons.star,
                size: 65,
                color: Colors.orange,
                shadows: [
                  Shadow(
                    blurRadius: 3,
                    color: Color.fromARGB(255, 36, 35, 0),
                    offset: Offset(0, 1))
                ],
              ),
              Center(
                child: FutureBuilder<int>(
                  future: UserController.fetchAndHandleCurrentLevel(user!.uid),
                  builder:(context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else {
                      final int currentLevel = snapshot.data ?? 0;
                      return Text('$currentLevel');
                    }
                }),)
            ],
          )
        )
      )
      );
  }
}