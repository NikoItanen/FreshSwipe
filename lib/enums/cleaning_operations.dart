//TODO: Add more operations to the cleaning enum.
enum CleaningOperations {
  vacuuming('Vacuuming', 50),
  dusting('Dusting', 30),
  mopping('Mopping', 80),
  trashRemoval('Trash Removal', 20,),
  dishWashing('Dish Washing', 50),
  windowCleaning('Window Cleaning', 100);


  const CleaningOperations(this.label, this.points);
  final String label;
  final int points;
}