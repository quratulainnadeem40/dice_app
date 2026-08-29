class RollHistoryItem {
  final String id;
  final List<int> results;
  final int total;
  final int diceCount;
  final int diceSides;
  final DateTime timestamp;

  RollHistoryItem({
    required this.id,
    required this.results,
    required this.total,
    required this.diceCount,
    required this.diceSides,
    required this.timestamp,
  });

  factory RollHistoryItem.fromMap(Map<String, dynamic> map) {
    return RollHistoryItem(
      id: map['id'] as String,
      results: List<int>.from(map['results'] as List),
      total: map['total'] as int,
      diceCount: map['diceCount'] as int,
      diceSides: map['diceSides'] as int,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'results': results,
      'total': total,
      'diceCount': diceCount,
      'diceSides': diceSides,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  String get diceNotation => '${diceCount}d$diceSides';
  String get timeFormatted {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get dateFormatted {
    final day = timestamp.day.toString().padLeft(2, '0');
    final month = timestamp.month.toString().padLeft(2, '0');
    final year = timestamp.year;
    return '$day/$month/$year';
  }
}