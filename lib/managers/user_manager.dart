import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserManager {

  static Future<int> fetchDayStreak() async {
    int dayStreak = 0;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        String userId = user.uid;

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
          dayStreak = data['dayStreak'];
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users points.');
      }
    } return dayStreak;
  }



  static Future<int> fetchAllCleaningPoints() async {
    int userCleaningPoints = 0;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        String userId = user.uid;

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
          userCleaningPoints = data['userCleaningPoints'];
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users points.');
      }
    } return userCleaningPoints;
  }

  static Future<int> fetchCleaningActivities() async {
    int cleaningActivities = 0;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        String userId = user.uid;

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
          cleaningActivities = data['cleaningActivities'];
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users points.');
      }
    } return cleaningActivities;
  }
  

  static Future<List<String>> fetchUnlockedRewards() async {
    List<String> unlockedRewards = [];
    
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
          unlockedRewards = List<String>.from(data['unlockedRewards'] ?? []);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unlocked rewards: $e');
      }
    }
    return unlockedRewards;
  }

  static Future<void> addNewReward(String rewardName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;

      try {
        DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);
        DocumentSnapshot userSnapshot = await userDocRef.get();

        if (userSnapshot.exists) {
          Map<String, dynamic> data  = userSnapshot.data() as Map<String, dynamic>;
          List<String> currentRewards = List<String>.from(data['unlockedRewards'] ?? []);
          if (!currentRewards.contains(rewardName)) {
            currentRewards.add(rewardName);
            await userDocRef.update({'unlockedRewards': currentRewards});
          }
        }
        } catch (e) {
          if (kDebugMode) {
          print('Error adding new reward: $e');
          }
        }
      }
    }
  }