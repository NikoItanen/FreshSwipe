import 'package:flutter/material.dart';
import 'pages/menu_page.dart';
import 'pages/login_page.dart';
import 'pages/room_page.dart';
import 'pages/user_page.dart';
import 'pages/rewards_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freshswipe/auth_builder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
  apiKey: '${dotenv.env['FIREBASE_API_KEY']}',
  authDomain: "${dotenv.env['FIREBASE_AUTH_DOMAIN']}",
  projectId: "${dotenv.env['FIREBASE_PROJECT_ID']}",
  storageBucket: "${dotenv.env['FIREBASE_STORAGE_BUCKET']}",
  messagingSenderId: "${dotenv.env['FIREBASE_MESSAGING_SENDER_ID']}",
  appId: "${dotenv.env['FIREBASE_APP_ID']}",
  measurementId: "${dotenv.env['FIREBASE_MEASUREMENT_ID']}"));
  runApp(const FreshSwipe());
}

class FreshSwipe extends StatelessWidget {
  const FreshSwipe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Title for the application
        title: "FreshSwipe",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        //Define the starting page.
        home: const AuthBuilder(),
        //Specify all routes to the created pages.
        routes: {
          '/menupage': (context) => const MenuPage(),
          '/loginpage': (context) => const LoginPage(),
          '/user': (context) => const UserPage(),
          '/rewards': (context) => const RewardPage(),
          '/rooms': (context) => const RoomsPage()
        });
  }
}
