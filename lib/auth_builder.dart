import 'package:firebase_auth/firebase_auth.dart';
import 'package:freshswipe/auth.dart';
import 'package:freshswipe/pages/menu_page.dart';
import 'package:freshswipe/pages/login_page.dart';
import 'package:flutter/material.dart';

//This class takes responsibility to create a new state after authentication is completed!

class AuthBuilder extends StatefulWidget {
  const AuthBuilder ({super.key});

  @override
  State<AuthBuilder> createState() => _AuthBuilderState();
}

  class _AuthBuilderState extends State<AuthBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: Auth().authStateChanges, builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
      if (snapshot.hasData) {
        return const MenuPage();
      }
      else {
        return const LoginPage();
      }
    },);
  }
}