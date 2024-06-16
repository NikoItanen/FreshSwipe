import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

// Fetch current logged in user.
  User ? get currentUser =>  _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

// Fetch users email address.
  Future<String?> getCurrentUserEmail() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.email;
    } else {
      return null;
    }
  }

// Fetch users id.
  Future<String?> getCurrentUserId() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  //Sign in method for Firebase Authentication.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password
      );
  }

  // Sign up method for Firebase Authentication.
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password
      );
  }

  // Sign out method for Firebase Authentication.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}