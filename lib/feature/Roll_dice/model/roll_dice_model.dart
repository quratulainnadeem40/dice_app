class DiceResult {
  final List<int> results;
  final int total;
  final int diceCount;
  final int diceSides;
  final DateTime timestamp;

  DiceResult({
    required this.results,
    required this.total,
    required this.diceCount,
    required this.diceSides,
    required this.timestamp,
  });

  int get average {
    if (results.isEmpty) return 0;
    return (total / results.length).ceil();
  }

  int get max {
    return results.isEmpty ? 0 : results.reduce((a, b) => a > b ? a : b);
  }

  int get min {
    return results.isEmpty ? 0 : results.reduce((a, b) => a < b ? a : b);
  }
}

class DiceConfig {
  final int diceCount;
  final int diceSides;
  final String diceColor;
  final double animationSpeed;

  DiceConfig({
    required this.diceCount,
    required this.diceSides,
    required this.diceColor,
    required this.animationSpeed,
  });

  factory DiceConfig.defaultConfig() {
    return DiceConfig(
      diceCount: 1,
      diceSides: 6,
      diceColor: 'purple',
      animationSpeed: 1.0,
    );
  }

  DiceConfig copyWith({
    int? diceCount,
    int? diceSides,
    String? diceColor,
    double? animationSpeed,
  }) {
    return DiceConfig(
      diceCount: diceCount ?? this.diceCount,
      diceSides: diceSides ?? this.diceSides,
      diceColor: diceColor ?? this.diceColor,
      animationSpeed: animationSpeed ?? this.animationSpeed,
    );
  }
}