import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title for the application
      title: 'FreshSwipe',
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 205, 246, 164),
        body: Center(
          heightFactor: 3.5,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // Title text to the login page.
            const Text('FreshSwipe',
                style: TextStyle(
                    fontSize: 48, color: Color.fromRGBO(64, 81, 47, 1))),
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
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 400,
                  child: TextField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )),
                  ),
                )),
            // Log in button
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  fixedSize: const Size(170, 40)),
              child: const Text('Log In'),
              onPressed: () {
                // TODO: Make the login logic here
                Navigator.pushNamed(context, '/menupage');
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0)),
              child: const Text('Create a new account!'),
              onPressed: () {
                // TODO: Make the login logic here
                print("Register button pressed!");
              },
            ),
          ]),
        ),
      ),
    );
  }
}
