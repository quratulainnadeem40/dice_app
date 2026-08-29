
import 'package:dice_app/feature/Multiplayers/controller/multi_player_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/player_card.dart';
import '../widgets/player_selector.dart';
import '../widgets/game_mode_card.dart';
import '../widgets/multiplayer_roll_button.dart';

class MultiplayerScreen extends GetView<MultiplayerController> {
  const MultiplayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0B1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('MULTIPLAYER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: controller.resetGame,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const GameModeCard(
                title: 'Pass & Play',
                description: 'Take turns on the same device',
                icon: Icons.people_alt_rounded,
              ),
              const SizedBox(height: 16),
              Obx(() => PlayerSelector(
                    count: controller.playerCount.value,
                    onChanged: controller.setupPlayers,
                  )),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() => ListView.separated(
                      itemCount: controller.players.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return PlayerCard(player: controller.players[index]);
                      },
                    )),
              ),
              const SizedBox(height: 10),
              Obx(() => MultiplayerRollButton(
                    playerName: controller.players.isNotEmpty
                        ? controller.players[controller.currentTurnIndex.value].name
                        : '',
                    onPressed: controller.rollDice,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}