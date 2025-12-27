class Habit {
  String name;
  bool isCompletedToday;
  int streak; // number of consecutive days completed

  Habit({required this.name, this.isCompletedToday = false, this.streak = 0});
}
