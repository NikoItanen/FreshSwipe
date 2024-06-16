import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int userCleaningPoints;
  final int cleaningActivities;
  final int dayStreak;
  final int cleanerLevel;
  final Timestamp userCreated;
  final List<dynamic> unlockedRewards;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userCleaningPoints,
    required this.cleaningActivities,
    required this.dayStreak,
    required this.cleanerLevel,
    required this.userCreated,
    required this.unlockedRewards
  });
  
  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      userCleaningPoints: data['userCleaningPoints'],
      cleaningActivities: data['cleaningActivities'],
      dayStreak: data['dayStreak'],
      cleanerLevel: data['cleanerLevel'],
      userCreated: data['userCreated'] as Timestamp,
      unlockedRewards: data['unlockedRewards']);
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'userCleaningPoints': userCleaningPoints,
      'cleaningActivities': cleaningActivities,
      'dayStreak': dayStreak,
      'cleanerLevel': cleanerLevel,
      'userCreated': userCreated,
      'unlockedRewards': unlockedRewards
    };
  }

  static Future<void> add(User user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.id).set(user.toMap());
  }

  static Future<User?> get(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        return User.fromFirestore(userSnapshot);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user: $e');
      }
    }
    return null;
  }
}