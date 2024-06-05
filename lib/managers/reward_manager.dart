import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freshswipe/managers/user_manager.dart';

class RewardManager {
  static Future<void> checkAndUnlockRewards () async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {

        int cleaningPoints = await UserManager.fetchAllCleaningPoints();
        int cleaningActivities = await UserManager.fetchCleaningActivities();
        List<String> unlockedRewards = await UserManager.fetchUnlockedRewards();

        Future<void> addRewardIfNotUnlocked(String rewardName) async {
          if (!unlockedRewards.contains('rewardName')) {
            await UserManager.addNewReward(rewardName);
          }
        }

        if (cleaningActivities >= 1) {
          await addRewardIfNotUnlocked('firstCleaning');
        }

        if (cleaningActivities >= 10) {
          await addRewardIfNotUnlocked('firstTen');
        }

        if (cleaningPoints >= 1000) {
          await addRewardIfNotUnlocked("littlePoints");
        }

      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking and unlocking rewards: $e');
      }
    }
  }
}