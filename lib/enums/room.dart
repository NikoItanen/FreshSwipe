import 'package:flutter/material.dart';

enum RoomType {
  bedroom('Bedroom', Icons.bed),
  bathroom('Bathroom', Icons.bathtub),
  kitchen('Kitchen', Icons.kitchen),
  livingRoom('Living Room', Icons.chair),
  diningRoom('Dining Room', Icons.restaurant),
  laundryRoom('Laundry Room', Icons.local_laundry_service),
  garage('Garage', Icons.directions_car),
  balcony('Balcony', Icons.balcony),
  gym('Gym', Icons.fitness_center),
  library('Library', Icons.auto_stories),
  homeOffice('Home Office', Icons.laptop),
  gameRoom('Game Room', Icons.gamepad),
  theater('Theater', Icons.theaters),
  sauna('Sauna', Icons.spa),
  storageRoom('Storage Room', Icons.inventory),
  walkInCloset('Walk In Closet', Icons.checkroom),
  other('Other', Icons.question_mark);

  const RoomType(this.label, this.icon);
  final String label;
  final IconData icon;
}