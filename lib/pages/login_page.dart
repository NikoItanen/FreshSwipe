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

  //Controllers for input fields.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  //Sign in method
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
  //Sign up method
  Future<void> signUpWithEmailAndPassword() async {
    //Check if password and verify password are both same.
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

        final user = FirebaseAuth.instance.currentUser;
        await addUserDetails(
          _firstNameController.text,
          _lastNameController.text,
          _emailController.text,
          user!.uid
  );

    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  //Initalise and Send new required user data to the Firestore Cloud.
  Future<void> addUserDetails(
    String firstName, String lastName, String email, String userId) async {
      int points = 0;
      int activities = 0;
      int dayStreak = 0;
      int cleanerLevel = 1;
      Timestamp userCreated = Timestamp.now();
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'userCleaningPoints': points,
        'cleaningActivities': activities,
        'dayStreak': dayStreak,
        'userCreated': userCreated,
        'cleanerLevel': cleanerLevel
      });
    }

  //Boolean value for switch between login and sign up states.
  void _isLoginSwitch(bool value) {
    setState(() {
      isLogin = value;
    });
  }

  // Login state built here:
  Widget _onLoginView() {
    return Column(
      key: const ValueKey('login'),
      children: [
      // Email input field.
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      key: const Key('emailField'),
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
                      key: const Key('passwordField'),
                      obscureText: _obscurePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            key: const Key('passwordToggleIcon'),
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
                key: const Key('loginButton'),
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
                key: const Key('createAccountButton'),
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

    //Sign up state built here:
    Widget _onSignUpView() {
    return Column(
      key: const ValueKey('signUp'),
      children: [
      // Email input field.
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      key: const Key('emailField'),
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
                      key: const Key('firstNameField'),
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
                      key: const Key('lastNameField'),
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
                      key: const Key('passwordField'),
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
                      key: const Key('verifyPasswordField'),
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
              // Sing Up button
              TextButton(
                key: const Key('signUpButton'),
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(0, 3, 72, 1),
                    fixedSize: const Size(170, 40)),
                child: const Text('Sign Up'),
                onPressed: () {
                  signUpWithEmailAndPassword();
                },
              ),
              // Back to login inputs
              TextButton(
                key: const Key('alreadyHaveAccountButton'),
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

  // Content build here:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Center(
            heightFactor: 1.5,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  AnimatedSwitcher(duration: const Duration(milliseconds: 500), child: isLogin == true? const Image(
                      image: AssetImage('assets/freshswipe-1.png'),
                      width: 300,
                      height: 300) : const SizedBox(height: 10,),),
                  
                  // Title text to the login page.
                  const Text('FreshSwipe',
                      style: TextStyle(
                          fontSize: 48, color: Color.fromRGBO(0, 3, 72, 1))),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child,);
                    },
                    child: isLogin ? _onLoginView() : _onSignUpView(),),
                    Text(errorMessage == '' ? '' : '$errorMessage')
            ]),
          ),
        ));
  }
}
