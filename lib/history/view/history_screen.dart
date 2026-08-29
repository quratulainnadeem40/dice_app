import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> historyItems = [
      {'dice': '5 Dice', 'total': 22, 'time': 'Today, 10:45 AM', 'values': [5, 4, 6, 3, 4]},
      {'dice': '3 Dice', 'total': 13, 'time': 'Today, 10:30 AM', 'values': [4, 4, 5]},
      {'dice': '2 Dice', 'total': 8, 'time': 'Today, 09:15 AM', 'values': [6, 2]},
      {'dice': '1 Dice', 'total': 4, 'time': 'Today, 09:00 AM', 'values': [4]},
    ];

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('HISTORY', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: historyItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CustomColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(item['dice'], style: const TextStyle(color: CustomColors.textSecondary)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 4,
                        children: (item['values'] as List<int>).map((val) => Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(color: CustomColors.primaryPurple, borderRadius: BorderRadius.circular(4)),
                          child: Center(child: Text('$val', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                        )).toList(),
                      ),
                      const SizedBox(height: 4),
                      Text(item['time'], style: const TextStyle(color: CustomColors.textSecondary, fontSize: 10)),
                    ],
                  ),
                ),
                Text('${item['total']}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        },
      ),
    );
  }
}