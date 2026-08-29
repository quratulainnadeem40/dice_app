class HomeModel {
  final String userName;
  final int totalRolls;
  final int lastRollResult;
  final String recentAchievement;

  HomeModel({
    required this.userName,
    required this.totalRolls,
    required this.lastRollResult,
    required this.recentAchievement,
  });

  // Shortcut getter so both lastRoll & lastRollResult work seamlessly
  int get lastRoll => lastRollResult;
}