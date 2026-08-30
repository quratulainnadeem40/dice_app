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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'diceValues': diceValues,
      'totalResult': totalResult,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory RollHistoryModel.fromMap(Map<String, dynamic> map) {
    return RollHistoryModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      diceValues: (map['diceValues'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      totalResult: (map['totalResult'] as num?)?.toInt() ?? 0,
      dateTime: map['dateTime'] != null
          ? DateTime.tryParse(map['dateTime'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}