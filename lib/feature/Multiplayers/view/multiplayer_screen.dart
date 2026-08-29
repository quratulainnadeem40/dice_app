import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';

class MultiplayerScreen extends StatelessWidget {
  const MultiplayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('MULTIPLAYER', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Mode Selector
            Container(
              decoration: BoxDecoration(
                color: CustomColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.vertical(12),
                      decoration: BoxDecoration(
                        color: CustomColors.primaryPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text('LOCAL', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  ),
                  Expanded(
                    child: Center(child: Text('ONLINE', style: TextStyle(color: CustomColors.textSecondary, fontWeight: FontWeight.bold))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Player List
            _buildPlayerTile('Player 1', '24', isUser: true),
            const SizedBox(height: 10),
            _buildPlayerTile('Player 2', '18'),
            const SizedBox(height: 10),
            _buildPlayerTile('Player 3', '15'),
            
            const Spacer(),

            // Roll Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                ),
                child: const Text('ROLL DICE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            
            // Winner Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.emoji_events, color: Colors.amber),
                      SizedBox(width: 8),
                      Text('Winner', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Text('Player 1', style: TextStyle(color: CustomColors.primaryNeon, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerTile(String name, String score, {bool isUser = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: CustomColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: isUser ? Border.all(color: CustomColors.primaryNeon) : null,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: CustomColors.surfaceLight,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          if (isUser) const Text(' (You)', style: TextStyle(color: CustomColors.textSecondary, fontSize: 12)),
          const Spacer(),
          Text(score, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}