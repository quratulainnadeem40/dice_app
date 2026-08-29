import 'package:dice_app/history/model/history_model.dart';
import 'package:get/get.dart';


class HistoryController extends GetxController {
  var historyList = <RollHistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSampleHistory();
  }

  void loadSampleHistory() {
    historyList.value = [
      RollHistoryModel(
        id: '1',
        diceCount: 5,
        results: [4, 5, 2, 6, 5],
        total: 22,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      RollHistoryModel(
        id: '2',
        diceCount: 3,
        results: [3, 4, 6],
        total: 13,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      RollHistoryModel(
        id: '3',
        diceCount: 2,
        results: [4, 4],
        total: 8,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];
  }

  void addRollToHistory(int diceCount, List<int> results, int total) {
    historyList.insert(
      0,
      RollHistoryModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        diceCount: diceCount,
        results: results,
        total: total,
        timestamp: DateTime.now(),
      ),
    );
  }

  void clearHistory() {
    historyList.clear();
  }
}