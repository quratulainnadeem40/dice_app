class PlayerModel {
  final String id;
  final String name;
  int score;
  bool isCurrentTurn;

  PlayerModel({
    required this.id,
    required this.name,
    this.score = 0,
    this.isCurrentTurn = false,
  });
}