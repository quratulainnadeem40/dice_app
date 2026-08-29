import 'package:flutter/material.dart';
import '../../../core/widgets/empty_state.dart';

class HistoryEmptyState extends StatelessWidget {
  final VoidCallback? onAction;

  const HistoryEmptyState({
    Key? key,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: 'No Roll History',
      subtitle: 'Start rolling the dice to see your history here',
      icon: Icons.history_rounded,
      action: onAction != null
          ? ElevatedButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.casino_rounded),
              label: const Text('Roll Now'),
            )
          : null,
    );
  }
}