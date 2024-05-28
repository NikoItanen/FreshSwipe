import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool _obscureText = true;
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title for the application
      title: 'FreshSwipe',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Center(
          heightFactor: 1.5,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Image(image: AssetImage('assets/freshswipe-1.png'), width: 300, height: 300),
            // Title text to the login page.
            const Text('FreshSwipe',
                style: TextStyle(
                    fontSize: 48, color: Color.fromRGBO(0, 3, 72, 1))),
            const SizedBox(height: 20),
            // Username input field.
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 400,
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
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
                          icon: const Icon(Icons.remove_red_eye, color: Color.fromRGBO(0, 3, 72, 1),),
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
                  backgroundColor: const Color.fromRGBO(0, 3, 72, 1),
                  fixedSize: const Size(170, 40)),
              child: const Text('Log In'),
              onPressed: () {
                // TODO: Make the login logic here
                String username = _usernameController.text;
                User user = User(username: username, joiningDate: DateTime.now());
                if (kDebugMode) {
                  print('User: ${user.getUsername} logged in successfully!');
                }
                Navigator.pushNamed(context, '/menupage');
              },
            ),
            // Register button
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 153, 163, 255)),
              child: const Text('Create a new account!', style: TextStyle(fontSize: 12),),
              onPressed: () {
                // TODO: Make the login logic here
                if (kDebugMode) {
                  print("Register button pressed!");
                }
              },
            ),
          ]),
        ),
        )
      ),
    );
  }
}
