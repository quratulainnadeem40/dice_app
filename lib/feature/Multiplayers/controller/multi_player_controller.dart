import 'dart:math';
import 'package:get/get.dart';
import '../model/player_model.dart';

class MultiplayerController extends GetxController {
  var playerCount = 2.obs;
  var players = <PlayerModel>[].obs;
  var currentTurnIndex = 0.obs;
  var lastRoll = 0.obs;

  @override
  void onInit() {
    super.onInit();
    setupPlayers(playerCount.value);
  }

  void setupPlayers(int count) {
    playerCount.value = count;
    players.value = List.generate(
      count,
      (index) => PlayerModel(
        id: '$index',
        name: 'Player ${index + 1}',
        isCurrentTurn: index == 0,
      ),
    );
    currentTurnIndex.value = 0;
    lastRoll.value = 0;
  }

  void rollDice() {
    if (players.isEmpty) return;

    final rolledValue = Random().nextInt(6) + 1;
    lastRoll.value = rolledValue;

    players[currentTurnIndex.value].score += rolledValue;
    nextTurn();
  }

  void nextTurn() {
    players[currentTurnIndex.value].isCurrentTurn = false;
    currentTurnIndex.value = (currentTurnIndex.value + 1) % players.length;
    players[currentTurnIndex.value].isCurrentTurn = true;
    players.refresh();
  }

  void resetGame() {
    setupPlayers(playerCount.value);
  }
}