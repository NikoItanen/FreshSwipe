import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Reward {
  final String name;
  final String description;
  final Icon icon;

  Reward({
    required this.name,
    required this.description,
    required this.icon,
  });

  // Method to add new reward for user and update it to the database.
  static Future<void> addNewReward(String userId, String rewardName) async {
    try {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);
      DocumentSnapshot userSnapshot = await userDocRef.get();

      if (userSnapshot.exists) {
        Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
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

  // Fetches all user's already unlocked rewards and returns it as list.
  static Future<List<String>> fetchUnlockedRewards(String userId) async {
    try {
      DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);
      DocumentSnapshot userSnapshot = await userDocRef.get();

      if (userSnapshot.exists) {
        Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
        return List<String>.from(data['unlockedRewards'] ?? []);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching unlocked rewards: $e');
      }
    }
    return [];
  }
}