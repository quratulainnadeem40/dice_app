class HomeStats {
  final int totalRolls;
  final int lastResult;
  final int maxRoll;
  final int minRoll;

  HomeStats({
    required this.totalRolls,
    required this.lastResult,
    required this.maxRoll,
    required this.minRoll,
  });

  factory HomeStats.empty() {
    return HomeStats(
      totalRolls: 0,
      lastResult: 0,
      maxRoll: 0,
      minRoll: 0,
    );
  }
}

class RecentRoll {
  final int result;
  final DateTime timestamp;
  final int diceCount;
  final int diceSides;

  RecentRoll({
    required this.result,
    required this.timestamp,
    required this.diceCount,
    required this.diceSides,
  });
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final bool isUnlocked;
  final double progress;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
    required this.progress,
  });
}