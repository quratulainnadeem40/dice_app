import 'package:flutter/material.dart';

class MultiplayerRollButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String playerName;

  const MultiplayerRollButton({
    Key? key,
    required this.onPressed,
    required this.playerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B5CF6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(
          'ROLL FOR $playerName',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}