import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:freshswipe/controllers/user_controller.dart';
import 'package:freshswipe/models/reward.dart';

class RewardController {

  // Add new reward for user.
  static Future<void> addReward(String rewardName) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        await Reward.addNewReward(userId, rewardName);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while adding reward: $e');
      }
    }
  }

  //Getter method for user's unlocked rewards.
  static Future<List<String>> getUnlockedRewards() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;
        return await Reward.fetchUnlockedRewards(userId);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while fetching unlocked rewards: $e');
      }
    }
    return [];
  }


  //Check all the values needed to open new awards. If the user's values meet the requirements, a new award will be added.
  static Future<void> checkAndUnlockRewards () async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {

        int cleaningPoints = await UserController.fetchAllCleaningPoints(user.uid);
        int cleaningActivities = await UserController.fetchCleaningActivities(user.uid);
        List<String> unlockedRewards = await getUnlockedRewards();
        int currentLevel = await UserController.fetchAndHandleCurrentLevel(user.uid);
        int currentStreak = await UserController.fetchAndHandleDayStreak(user.uid);

        Future<void> addRewardIfNotUnlocked(String rewardName) async {
          if (!unlockedRewards.contains('rewardName')) {
            await addReward(rewardName);
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