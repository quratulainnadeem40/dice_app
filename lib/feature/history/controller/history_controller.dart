import 'package:dice_app/feature/history/model/history_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoryController extends GetxController {
  final GetStorage _storage = GetStorage();
  static const String _storageKey = 'dice_roll_history';

  // ==========================================================
  // HISTORY LIST
  // ==========================================================

  final RxList<RollHistoryModel> historyList =
      <RollHistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadHistoryFromStorage();
  }

  // ==========================================================
  // LOAD HISTORY FROM STORAGE
  // ==========================================================

  void _loadHistoryFromStorage() {
    try {
      final dynamic rawData = _storage.read(_storageKey);
      if (rawData != null && rawData is List) {
        final List<RollHistoryModel> loaded = [];
        for (final item in rawData) {
          if (item is Map<String, dynamic>) {
            loaded.add(RollHistoryModel.fromMap(item));
          } else if (item is Map) {
            loaded.add(RollHistoryModel.fromMap(Map<String, dynamic>.from(item)));
          }
        }
        historyList.assignAll(loaded);
        debugPrint('Loaded ${loaded.length} history items from local storage.');
      }
    } catch (e) {
      debugPrint('Error loading history from storage: $e');
    }
  }

  // ==========================================================
  // SAVE HISTORY TO STORAGE
  // ==========================================================

  Future<void> _saveHistoryToStorage() async {
    try {
      final List<Map<String, dynamic>> rawList =
          historyList.map((item) => item.toMap()).toList();
      await _storage.write(_storageKey, rawList);
      debugPrint('Saved ${rawList.length} history items to local storage.');
    } catch (e) {
      debugPrint('Error saving history to storage: $e');
    }
  }

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
    historyList.refresh();

    _saveHistoryToStorage();

    debugPrint(
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
    historyList.refresh();
    _saveHistoryToStorage();
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
    historyList.refresh();
    _saveHistoryToStorage();
  }

  // ==========================================================
  // CLEAR HISTORY
  // ==========================================================

  void clearHistory() {
    historyList.clear();
    historyList.refresh();
    _saveHistoryToStorage();
  }

  // Alias
  void clearAllHistory() {
    clearHistory();
  }
}