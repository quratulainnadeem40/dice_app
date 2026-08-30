import 'package:dice_app/feature/history/model/history_model.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  // ==========================================================
  // HISTORY LIST
  // ==========================================================

  final history = <HistoryModel>[].obs;

  // ==========================================================
  // ADD HISTORY
  // ==========================================================

  void addHistory({
    required List<int> results,
    required int playerCount,
    required int diceSides,
  }) {
    if (results.isEmpty) {
      return;
    }

    final record = HistoryModel(
      results: List<int>.from(results),
      playerCount: playerCount,
      diceSides: diceSides,
      dateTime: DateTime.now(),
    );

    history.insert(0, record);
  }

  // ==========================================================
  // CLEAR HISTORY
  // ==========================================================

  void clearHistory() {
    history.clear();
  }

  // ==========================================================
  // REMOVE ONE RECORD
  // ==========================================================

  void removeHistory(int index) {
    if (index < 0 || index >= history.length) {
      return;
    }

    history.removeAt(index);
  }

  // ==========================================================
  // HISTORY COUNT
  // ==========================================================

  int get historyCount {
    return history.length;
  }
}