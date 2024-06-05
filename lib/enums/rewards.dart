import 'package:flutter/material.dart';

enum Reward {
  firstCleaning("Beginner Cleaner", "Perform the first cleaning operation.", Icons.schedule),
  firstTen("First Ten Done", "Perform the first ten cleaning operations.", Icons.schedule),
  littlePoints("Sparkling Achiever", "Collect 1000 cleaning points.", Icons.timeline),
  dustBuster("Dust Buster", "Vacuum for the first time.", Icons.cleaning_services),
  dishWasher("Dishwasher", "Wash dishes for the first time.", Icons.coffee),
  bedMaker("Bed Maker", "Make the bed for the first time.", Icons.bed),
  basicOrganizer("Basic Organizer", "Arrange items for the first time.", Icons.category),
  floorSweeper("Floor Sweeper", "Sweep the floor for the first time.", Icons.cleaning_services),
  blitzCleaner("Blitz Cleaner", "Clean all rooms at once for the first time.", Icons.clean_hands),
  weeklongClean("Weeklong Clean", "Complete at least one cleaning task every day for a week.", Icons.schedule);


  const Reward(this.title, this.description, this.icon);
  final String title;
  final String description;
  final IconData icon;
}