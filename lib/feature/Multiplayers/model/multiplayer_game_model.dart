import 'player_model.dart';

class MultiplayerGameModel {
  final List<PlayerModel> players;
  int currentTurnIndex;
  bool isGameFinished;

  MultiplayerGameModel({
    required this.players,
    this.currentTurnIndex = 0,
    this.isGameFinished = false,
  });
}