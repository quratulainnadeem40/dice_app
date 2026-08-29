class RollHistoryModel {
  final String id;
  final int diceCount;
  final List<int> results;
  final int total;
  final DateTime timestamp;

  RollHistoryModel({
    required this.id,
    required this.diceCount,
    required this.results,
    required this.total,
    required this.timestamp,
  });
}