import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freshswipe/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _obscureVerifyPassword = true;
  bool isLogin = true;
  String? errorMessage = '';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> signUpWithEmailAndPassword() async {
    if (_passwordController.text != _verifyPasswordController.text) {
      setState(() {
        errorMessage = 'Passwords do not match';
      });
      return;
    }
    try {
      await Auth().signUpWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text);

        addUserDetails(
          _firstNameController.text,
          _lastNameController.text,
          _emailController.text,
  );

    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> addUserDetails(
    String firstName, String lastName, String email) async {
      await FirebaseFirestore.instance.collection('users').add({
        'firstName': firstName,
        'lastName': lastName,
        'email': email
      });
    }

  void _isLoginSwitch(bool value) {
    setState(() {
      isLogin = value;
    });
  }

  Widget _onLoginView() {
    return Column(children: [
      // Email input field.
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                  )),
              //Password input field.
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      obscureText: _obscurePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Color.fromRGBO(0, 3, 72, 1),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
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
                  signInWithEmailAndPassword();
                },
              ),
              // Register button
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 153, 163, 255)),
                child: const Text(
                  'Create a new account!',
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  _isLoginSwitch(false);
                },
              )
    ],);
  }

    Widget _onSignUpView() {
    return Column(children: [
      // Email input field.
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                  )),
                  // First name input field.
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                    ),
                  )),
                  // Last name input field.
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        hintText: 'Last name',
                      ),
                    ),
                  )),
              //Password input field.
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      obscureText: _obscurePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Color.fromRGBO(0, 3, 72, 1),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          )),
                    ),
                  )),
                  //Verify Password
                  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      obscureText: _obscureVerifyPassword,
                      controller: _verifyPasswordController,
                      decoration: InputDecoration(
                          hintText: 'Verify Password',
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.remove_red_eye,
                              color: Color.fromRGBO(0, 3, 72, 1),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureVerifyPassword = !_obscureVerifyPassword;
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
                child: const Text('Sign Up'),
                onPressed: () {
                  signUpWithEmailAndPassword();
                },
              ),
              // Register button
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 153, 163, 255)),
                child: const Text(
                  'I already have an account!',
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                    _isLoginSwitch(true);
                  }
                ,
              )
    ],);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Center(
            heightFactor: 1.5,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Image(
                  image: AssetImage('assets/freshswipe-1.png'),
                  width: 300,
                  height: 300),
              // Title text to the login page.
              const Text('FreshSwipe',
                  style: TextStyle(
                      fontSize: 48, color: Color.fromRGBO(0, 3, 72, 1))),
              const SizedBox(height: 20),
              isLogin == true ? _onLoginView() : _onSignUpView(),
              Text(errorMessage == '' ? '' : '$errorMessage')
            ]),
          ),
        ));
  }
}
