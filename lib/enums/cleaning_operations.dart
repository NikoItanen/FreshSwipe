enum CleaningOperations {
  vacuuming('Vacuuming', 50),
  dusting('Dusting', 30),
  mopping('Mopping', 80),
  trashRemoval('Trash Removal', 20),
  dishWashing('Dish Washing', 50),
  windowCleaning('Window Cleaning', 100),
  bedMaking('Bed Making', 40),
  toiletCleaning('Toilet Cleaning', 60),
  showerScrubbing('Shower Scrubbing', 70),
  mirrorCleaning('Mirror Cleaning', 40),
  floorPolishing('Floor Polishing', 90),
  laundryFolding('Laundry Folding', 60),
  furniturePolishing('Furniture Polishing', 70),
  carpetCleaning('Carpet Cleaning', 80),
  applianceCleaning('Appliance Cleaning', 60),
  silverwarePolishing('Silverware Polishing', 50),
  wallWiping('Wall Wiping', 40),
  ceilingDusting('Ceiling Dusting', 50),
  blindCleaning('Blind Cleaning', 60),
  bookShelfArranging('Bookshelf Arranging', 120),
  computerKeyboardCleaning('Computer Keyboard Cleaning', 70),
  gameConsoleCleaning('Clean Game Console', 40),
  projectorCleaning('Clean Projector', 30),
  seatCleaning('Clean Seat', 50),
  saunaCeilingsCleaning('Clean Ceilings', 300),
  shelvingCleaning('Clean Shelves', 100),
  clothesFolding('Fold Clothes', 70);



  const CleaningOperations(this.label, this.points);
  final String label;
  final int points;
}