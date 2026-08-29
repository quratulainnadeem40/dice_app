import 'package:flutter/material.dart';

class DiceSidesSelector extends StatelessWidget {
  final int sides;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const DiceSidesSelector({
    Key? key,
    required this.sides,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A34),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Number of Sides', style: TextStyle(color: Colors.white, fontSize: 16)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.white70),
                onPressed: onDecrement,
              ),
              Text(
                '$sides',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Colors.white70),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}