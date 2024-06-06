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
        int currentLevel = await UserManager.fetchAndHandleCurrentLevel();
        int currentStreak = await UserManager.fetchAndHandleDayStreak();

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

        if (cleaningActivities >= 50) {
          await addRewardIfNotUnlocked('firstFifty');
        }

        if (cleaningPoints >= 1000) {
          await addRewardIfNotUnlocked("littlePoints");
        }

        if (cleaningPoints >= 50000) {
          await addRewardIfNotUnlocked("hugePoints");
        }

        if (currentLevel >= 2) {
          await addRewardIfNotUnlocked("shiningStar");
        }

        if (currentLevel >= 20) {
          await addRewardIfNotUnlocked("cleaningMaster");
        }

        if (currentLevel >= 20) {
          await addRewardIfNotUnlocked("cleaningMaster");
        }

        if (currentStreak >= 7) {
          await addRewardIfNotUnlocked("consistentCleaner");
        }

        if (currentStreak >= 30) {
          await addRewardIfNotUnlocked("masterStreaker");
        }

        if (currentStreak >= 90) {
          await addRewardIfNotUnlocked("cleaningAddict");
        }

        if (currentStreak >= 180) {
          await addRewardIfNotUnlocked("spotlessRecord");
        }

        if (currentStreak >= 365) {
          await addRewardIfNotUnlocked("oneYearClean");
        }

        

      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking and unlocking rewards: $e');
      }
    }
  }
}