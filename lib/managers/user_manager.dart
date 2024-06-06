import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freshswipe/enums/cleaner_levels.dart';

class UserManager {

  static Future<int> fetchAndHandleDayStreak() async {
    int dayStreak = 0;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        String userId = user.uid;

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
          Timestamp latestActivityTimestamp = data['latestActivity'];
          DateTime latestActivity = latestActivityTimestamp.toDate();

          DateTime now = DateTime.now();
          DateTime today = DateTime(now.year, now.month, now.day);
          DateTime lastActivityDay = DateTime(latestActivity.year, latestActivity.month, latestActivity.day);

          if (lastActivityDay.isAtSameMomentAs((today.subtract(const Duration(days: 1))))) {
            dayStreak = data['dayStreak'] + 1;
          } else if (lastActivityDay.isAtSameMomentAs((today))) {
            dayStreak = data['dayStreak'];
          } else {
            dayStreak = 0;
          }

          await FirebaseFirestore.instance.collection('users').doc(userId).update(({'dayStreak': dayStreak}));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user's streak");
      }
    } return dayStreak;
  }

  static Future<int> fetchAndHandleCurrentLevel() async {
    int currentLevel = 0;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        String userId = user.uid;

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
          int userCleaningPoints = data['userCleaningPoints'];


          for (var level in Cleanerlevels.values) {
            if (userCleaningPoints >= level.neededPoints) {
              currentLevel = level.level;
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users points.');
      }
    } return currentLevel;
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

  static Future<DateTime?> fetchUserCreatedDate() async {

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        String userId = user.uid;

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userSnapshot.exists) {
          Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
          Timestamp userCreatedData = data['userCreated'];
          DateTime userCreated = userCreatedData.toDate();

          return userCreated;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users points.');
      }
    } return null;
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