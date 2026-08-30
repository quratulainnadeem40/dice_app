class RollHistoryModel {
  final String id;
  final String title;
  final int playerCount;
  final int diceSides;
  final List<int> diceValues;
  final List<String> playerNames;
  final int totalResult;
  final DateTime dateTime;

  RollHistoryModel({
    required this.id,
    required this.title,
    this.playerCount = 1,
    this.diceSides = 6,
    required this.diceValues,
    required this.playerNames,
    required this.totalResult,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'playerCount': playerCount,
      'diceSides': diceSides,
      'diceValues': diceValues,
      'playerNames': playerNames,
      'totalResult': totalResult,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory RollHistoryModel.fromMap(Map<String, dynamic> map) {
    final List<int> values = (map['diceValues'] as List<dynamic>?)
            ?.map((e) => (e as num).toInt())
            .toList() ??
        [];

    final List<String> names = (map['playerNames'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        List.generate(
          values.isNotEmpty ? values.length : 1,
          (i) => 'Player ${i + 1}',
        );

    final int pCount = (map['playerCount'] as num?)?.toInt() ??
        (values.isNotEmpty ? values.length : 1);

    return RollHistoryModel(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      playerCount: pCount,
      diceSides: (map['diceSides'] as num?)?.toInt() ?? 6,
      diceValues: values,
      playerNames: names,
      totalResult: (map['totalResult'] as num?)?.toInt() ?? 0,
      dateTime: map['dateTime'] != null
          ? DateTime.tryParse(map['dateTime'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }
}