import 'package:flutter/material.dart';
import '../model/player_model.dart';

class PlayerCard extends StatelessWidget {
  final PlayerModel player;

  const PlayerCard({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A34),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: player.isCurrentTurn ? const Color(0xFF8B5CF6) : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: player.isCurrentTurn ? const Color(0xFF8B5CF6) : Colors.white12,
                child: Text(
                  player.name[0],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (player.isCurrentTurn)
                    const Text(
                      'Turn Now',
                      style: TextStyle(color: Color(0xFF8B5CF6), fontSize: 12),
                    ),
                ],
              ),
            ],
          ),
          Text(
            '${player.score} pts',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}