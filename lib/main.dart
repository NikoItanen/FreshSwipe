import 'package:flutter/material.dart';

void main() {
  runApp(const FreshSwipe());
}

class FreshSwipe extends StatelessWidget {
  const FreshSwipe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FreshSwipe',
      home: Scaffold(
        body: Center(
          heightFactor: 3.5,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Title text to the login page.
            const Text('FreshSwipe',
                style: TextStyle(
                    fontSize: 48, color: Color.fromRGBO(64, 81, 47, 100))),
            const SizedBox(height: 20),
            // Username input field.
            const Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Username',
                    ),
                  ),
                )),
            //Password input field.
            const Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 400,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                )),
            // Log in button
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black),
              child: const Text('Log In'),
              onPressed: () {
                // TODO: Make the login logic here
                print("Login painettu");
              },
            ),
          ]),
        ),
      ),
    );
  }
}
