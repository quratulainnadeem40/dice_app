import 'package:dice_app/feature/history/model/history_model.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  // ==========================================================
  // HISTORY LIST
  // ==========================================================

  final RxList<RollHistoryModel> historyList =
      <RollHistoryModel>[].obs;

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

    final int total =
        results.fold(0, (sum, value) => sum + value);

    final String title =
        '$playerCount Player${playerCount > 1 ? 's' : ''} (D$diceSides)';

    final RollHistoryModel newHistory =
        RollHistoryModel(
      id: DateTime.now()
          .microsecondsSinceEpoch
          .toString(),
      title: title,
      diceValues: List<int>.from(results),
      totalResult: total,
      dateTime: DateTime.now(),
    );

    // Newest result goes to the top
    historyList.insert(0, newHistory);

    // Make sure GetX updates listeners
    historyList.refresh();

    print(
      'HISTORY ADDED: ${newHistory.title} '
      '${newHistory.diceValues}',
    );
  }

  // ==========================================================
  // REMOVE ONE HISTORY ITEM
  // ==========================================================

  void removeHistory(int index) {
    if (index < 0 || index >= historyList.length) {
      return;
    }

    historyList.removeAt(index);
  }

  // ==========================================================
  // INSERT HISTORY ITEM
  // ==========================================================

  void insertHistory(
    int index,
    RollHistoryModel item,
  ) {
    if (index < 0 || index > historyList.length) {
      return;
    }

    historyList.insert(index, item);
  }

  // ==========================================================
  // CLEAR HISTORY
  // ==========================================================

  void clearHistory() {
    historyList.clear();
  }

  // Alias
  void clearAllHistory() {
    clearHistory();
  }
}