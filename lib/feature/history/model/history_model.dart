class RollHistoryModel {
  final String id;
  final String title;
  final List<int> diceValues;
  final int totalResult;
  final DateTime dateTime;

  RollHistoryModel({
    required this.id,
    required this.title,
    required this.diceValues,
    required this.totalResult,
    required this.dateTime,
  });
}