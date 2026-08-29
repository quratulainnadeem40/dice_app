import 'dart:math';
import 'package:get/get.dart';

class Player {
  final String name;
  RxInt score;
  Player({required this.name, required int score}) : score = score.obs;
}

class MultiplayerController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0: Local, 1: Online
  final RxList<Player> players = <Player>[
    Player(name: 'Player 1 (You)', score: 24),
    Player(name: 'Player 2', score: 18),
    Player(name: 'Player 3', score: 15),
  ].obs;

  final RxString winnerName = 'Player 1'.obs;

  void rollForCurrentPlayer() {
    for (var player in players) {
      player.score.value += Random().nextInt(6) + 1;
    }
    _updateWinner();
  }

  void _updateWinner() {
    Player currentLeader = players[0];
    for (var player in players) {
      if (player.score.value > currentLeader.score.value) {
        currentLeader = player;
      }
    }
    winnerName.value = currentLeader.name.replaceAll(' (You)', '');
  }
}