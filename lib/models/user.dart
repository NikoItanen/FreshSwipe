import 'package:freshswipe/models/reward.dart';

class User {
  final String username;
  final DateTime joiningDate;
  List<Reward> claimedRewards = [];
  double totalCleanlinessRate = 5.0;

  User({
    required this.username,
    required this.joiningDate,
  });

  String get getUsername => username;
}

