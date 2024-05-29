import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static Future<Map<String, dynamic>> getUserData(String email) async {
    final snapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    } else {
      return {};
    }
  }
}