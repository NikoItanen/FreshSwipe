import 'package:flutter/material.dart';

enum Reward {
  firstCleaning("Beginner Cleaner", "Perform the first cleaning operation.", Icons.schedule),
  firstTen("First Ten Done", "Perform the first ten cleaning operations.", Icons.schedule),
  firstFifty("First Fifty Done", "Perform the first fifty cleaning operations.", Icons.schedule),
  littlePoints("Sparkling Achiever", "Collect 1000 cleaning points.", Icons.timeline),
  hugePoints("Point Master", "Collect 50 000 cleaning points.", Icons.timeline),
  shiningStar("Shining Star", "Reach the cleaning level 2.", Icons.star),
  cleaningMaster("Cleaning Master", "Reach the cleaning level 20.", Icons.star),
  consistentCleaner("Consistent Cleaner", "Maintain a cleaning streak for a week.", Icons.timelapse),
  masterStreaker("Master Streaker", "Maintain a cleaning streak for a month.", Icons.timelapse),
  cleaningAddict("Cleaning Addict", "Maintain a cleaning streak for three months.", Icons.timelapse),
  spotlessRecord("Spotless Record", "Maintain a cleaning streak for six months.", Icons.timelapse),
  oneYearClean("One Year Clean", "Maintain a cleaning streak for a year.", Icons.timelapse);

  const Reward(this.title, this.description, this.icon);
  final String title;
  final String description;
  final IconData icon;
}