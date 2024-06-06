enum Cleanerlevels {
  first(1, 0),
  second(2, 500),
  third(3, 1200),
  fourth(4, 2000),
  fifth(5, 3000),
  sixth(6, 4200),
  seventh(7, 5600),
  eighth(8, 7200),
  ninth(9, 9000),
  tenth(10, 11000),
  eleventh(11, 13200),
  twelfth(12, 15600),
  thirteenth(13, 18200),
  fourteenth(14, 21000),
  fifteenth(15, 24000),
  sixteenth(16, 27200),
  seventeenth(17, 30600),
  eighteenth(18, 34200),
  nineteenth(19, 38000),
  twentieth(20, 42000);

  const Cleanerlevels(this.level, this.neededPoints);
  final int level;
  final int neededPoints;
}