import 'package:flutter/material.dart';
import 'package:freshswipe/enums/cleaning_operations.dart';


//Define all possible room types that can be set to a new room.
enum RoomType {
  bedroom('Bedroom', Icons.bed, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.bedMaking,
    CleaningOperations.mirrorCleaning,
    CleaningOperations.wallWiping,
  ]),
  bathroom('Bathroom', Icons.bathtub, [
    CleaningOperations.vacuuming,
    CleaningOperations.mopping,
    CleaningOperations.trashRemoval,
    CleaningOperations.windowCleaning,
    CleaningOperations.toiletCleaning,
    CleaningOperations.showerScrubbing,
    CleaningOperations.mirrorCleaning,
    CleaningOperations.wallWiping,
  ]),
  kitchen('Kitchen', Icons.kitchen, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.mopping,
    CleaningOperations.dishWashing,
    CleaningOperations.windowCleaning,
    CleaningOperations.trashRemoval,
    CleaningOperations.applianceCleaning,
  ]),
  livingRoom('Living Room', Icons.chair, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.furniturePolishing,
    CleaningOperations.wallWiping,
  ]),
  diningRoom('Dining Room', Icons.restaurant, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.silverwarePolishing,
    CleaningOperations.wallWiping,
  ]),
  laundryRoom('Laundry Room', Icons.local_laundry_service, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.floorPolishing,
    CleaningOperations.laundryFolding,
  ]),
  garage('Garage', Icons.directions_car, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.floorPolishing,
    CleaningOperations.applianceCleaning,
  ]),
  balcony('Balcony', Icons.balcony, [
    CleaningOperations.dusting,
    CleaningOperations.windowCleaning,
    CleaningOperations.blindCleaning,
  ]),
  gym('Gym', Icons.fitness_center, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.applianceCleaning,
    CleaningOperations.mirrorCleaning,
  ]),
  library('Library', Icons.auto_stories, [
    CleaningOperations.dusting,
    CleaningOperations.bookShelfArranging,
    CleaningOperations.mirrorCleaning,
  ]),
  homeOffice('Home Office', Icons.laptop, [
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.computerKeyboardCleaning,
    CleaningOperations.windowCleaning,
  ]),
  gameRoom('Game Room', Icons.gamepad, [
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.gameConsoleCleaning,
    CleaningOperations.floorPolishing,
  ]),
  theater('Theater', Icons.theaters, [
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.projectorCleaning,
    CleaningOperations.seatCleaning,
  ]),
  sauna('Sauna', Icons.spa, [
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.saunaCeilingsCleaning,
    CleaningOperations.floorPolishing,
  ]),
  storageRoom('Storage Room', Icons.inventory, [
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.shelvingCleaning,
    CleaningOperations.wallWiping,
  ]),
  walkInCloset('Walk In Closet', Icons.checkroom, [
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
    CleaningOperations.clothesFolding,
    CleaningOperations.mirrorCleaning,
  ]),
  other('Other', Icons.question_mark, [
    CleaningOperations.vacuuming,
    CleaningOperations.dusting,
    CleaningOperations.trashRemoval,
  ]);

  const RoomType(this.label, this.icon, this.roomTypeToOperations);
  final String label;
  final IconData icon;
  final List<CleaningOperations> roomTypeToOperations;
}

int calculateMaxPoints(RoomType roomType) {
  int maxPoints = 0;
  for (var operation in roomType.roomTypeToOperations) {
    maxPoints += operation.points;
  }
  return maxPoints;
}