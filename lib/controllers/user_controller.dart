import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freshswipe/enums/cleaner_levels.dart';
import 'package:freshswipe/models/user.dart';


class UserController {

  //This method is used to add new user to the database. Used while signing up.
  static Future<void> addUserDetails(User user) async {
    await User.add(user);
  }

  // Fetch data for all user's cleaning points.
  static Future<int> fetchAllCleaningPoints(String userId) async {
    int userCleaningPoints = 0;

    try {
      User? user = await User.get(userId);
      if (user != null) {
        userCleaningPoints = user.userCleaningPoints;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users points: $e');
      }
    }
    return userCleaningPoints;
  }

// Fetch data for user's total cleaning activities.
  static Future<int> fetchCleaningActivities(String userId) async {
    int cleaningActivities = 0;
    try {
      User? user = await User.get(userId);
      if (user != null) {
        cleaningActivities = user.cleaningActivities;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users cleaning activities: $e');
      }
    }
    return cleaningActivities;
  }

  // Fetch data for user creation timestamp.
  static Future<DateTime?> fetchUserCreatedDate(String userId) async {
    DateTime userCreated;
    try {
      User? user = await User.get(userId);
      if (user != null) {
        userCreated = user.userCreated.toDate();
        return userCreated;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user creation timestamp: $e');
      }
    }
    return null;
  }

  // Fetch data for daystreak, but also check if there is need to update new value.
  static Future<int> fetchAndHandleDayStreak(String userId) async {
    int dayStreak = 0;
    try {
      User? user = await User.get(userId);
      if (user != null) {
        Timestamp latestActivityTimestamp = user.userCreated;
        DateTime latestActivity = latestActivityTimestamp.toDate();

        DateTime now = DateTime.now();
        DateTime today = DateTime(now.year, now.month, now.day);
        DateTime lastActivityDay = DateTime(latestActivity.year, latestActivity.month, latestActivity.day);

        if (lastActivityDay.isAtSameMomentAs((today.subtract(const Duration(days: 1))))) {
          dayStreak = user.dayStreak + 1;
        } else if (lastActivityDay.isAtSameMomentAs((today))) {
          dayStreak = user.dayStreak;
        } else {
          dayStreak = 0;
        }

        await FirebaseFirestore.instance.collection('users').doc(userId).update({'dayStreak': dayStreak});
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user's streak: $e");
      }
    }
    return dayStreak;
  }

  // Fetch data for user's level, but also check if there is need to update new value for level.
  static Future<int> fetchAndHandleCurrentLevel(String userId) async {
    int currentLevel = 0;

    try {
      User? user = await User.get(userId);
      if (user != null) {
        int userCleaningPoints = user.userCleaningPoints;

        for (var level in Cleanerlevels.values) {
          if (userCleaningPoints >= level.neededPoints) {
            currentLevel = level.level;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user's level: $e");
      }
    }
    return currentLevel;
  }

  // Fetch user's first name.
  static Future<String> fetchUserFirstName(String userId) async {
    String firstName = 'Unknown';
    try {
      User? user = await User.get(userId);
      if (user != null) {
        firstName = user.firstName;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user first name: $e');
      }
    }
    return firstName;
  }

  // Fetch data for user's total cleaning activities.
  static Future<String> fetchEmailAddress(String userId) async {
    String email = 'Unknown';
    try {
      User? user = await User.get(userId);
      if (user != null) {
        return email = user.email;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users email: $e');
      }
    }
    return email;
  }
}