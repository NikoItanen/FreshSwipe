import 'package:flutter/material.dart';
import 'package:freshswipe/enums/cleaning_operations.dart';

enum RoomType {
  bedroom('Bedroom', Icons.bed, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  bathroom('Bathroom', Icons.bathtub, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  kitchen('Kitchen', Icons.kitchen, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
    CleaningOperations.dishWashing
  ]),
  livingRoom('Living Room', Icons.chair, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  diningRoom('Dining Room', Icons.restaurant, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  laundryRoom('Laundry Room', Icons.local_laundry_service, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  garage('Garage', Icons.directions_car, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  balcony('Balcony', Icons.balcony, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  gym('Gym', Icons.fitness_center, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  library('Library', Icons.auto_stories, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  homeOffice('Home Office', Icons.laptop, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  gameRoom('Game Room', Icons.gamepad, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  theater('Theater', Icons.theaters, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  sauna('Sauna', Icons.spa, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  storageRoom('Storage Room', Icons.inventory, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  walkInCloset('Walk In Closet', Icons.checkroom, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]),
  other('Other', Icons.question_mark, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.windowCleaning,
  ]);

  const RoomType(this.label, this.icon, this.roomTypeToOperations);
  final String label;
  final IconData icon;
  final List<CleaningOperations> roomTypeToOperations;
}
