import 'package:dice_app/feature/history/model/history_model.dart';
import 'package:get/get.dart';


class HistoryController extends GetxController {
  final RxList<RollHistoryModel> historyList = <RollHistoryModel>[].obs;

  // Add new history entry from RollDiceController
  void addHistory({
    required List<int> results,
    required int playerCount,
    required int diceSides,
  }) {
    final int total = results.fold(0, (sum, item) => sum + item);
    final String title = '$playerCount Player${playerCount > 1 ? 's' : ''} (D$diceSides)';

    final newHistory = RollHistoryModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      diceValues: results,
      totalResult: total,
      dateTime: DateTime.now(),
    );

    // List ke start me insert karte hain taaki new result top par dikhe
    historyList.insert(0, newHistory);
  }

  void removeHistory(int index) {
    if (index >= 0 && index < historyList.length) {
      historyList.removeAt(index);
    }
  }

  void insertHistory(int index, RollHistoryModel item) {
    if (index >= 0 && index <= historyList.length) {
      historyList.insert(index, item);
    }
  }

  void clearAllHistory() {
    historyList.clear();
  }

  // Alias for RollDiceController clear history call
  void clearHistory() {
    clearAllHistory();
  }
}