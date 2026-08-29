import 'package:dice_app/history/model/history_model.dart';
import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';

class HistoryController extends GetxController {
  final storageService = Get.find<StorageService>();
  final rollHistory = <RollHistoryItem>[].obs;
  final filteredHistory = <RollHistoryItem>[].obs;
  final selectedFilter = 'all'.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadHistory();
  }

  void _loadHistory() {
    // Load from storage or initialize with sample data
    rollHistory.addAll([
      RollHistoryItem(
        id: '1',
        results: [6],
        total: 6,
        diceCount: 1,
        diceSides: 6,
        timestamp: DateTime.now(),
      ),
      RollHistoryItem(
        id: '2',
        results: [3, 4, 2],
        total: 9,
        diceCount: 3,
        diceSides: 6,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      RollHistoryItem(
        id: '3',
        results: [4, 5],
        total: 9,
        diceCount: 2,
        diceSides: 6,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      RollHistoryItem(
        id: '4',
        results: [2, 3, 4, 5],
        total: 14,
        diceCount: 4,
        diceSides: 6,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      RollHistoryItem(
        id: '5',
        results: [1],
        total: 1,
        diceCount: 1,
        diceSides: 6,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ]);
    _applyFilters();
  }

  void _applyFilters() {
    List<RollHistoryItem> temp = rollHistory.toList();

    // Apply filter
    if (selectedFilter.value != 'all') {
      temp = temp
          .where((item) => item.diceNotation == selectedFilter.value)
          .toList();
    }

    // Apply search
    if (searchQuery.value.isNotEmpty) {
      temp = temp.where((item) {
        return item.total.toString().contains(searchQuery.value) ||
            item.diceNotation.contains(searchQuery.value);
      }).toList();
    }

    filteredHistory.value = temp;
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    _applyFilters();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void clearHistory() {
    rollHistory.clear();
    filteredHistory.clear();
  }

  void deleteItem(String id) {
    rollHistory.removeWhere((item) => item.id == id);
    _applyFilters();
  }

  List<String> get availableFilters {
    final filters = <String>{'all'};
    for (var item in rollHistory) {
      filters.add(item.diceNotation);
    }
    return filters.toList();
  }

  int get totalRolls => rollHistory.length;
  double get averageRoll =>
      rollHistory.isEmpty ? 0 : rollHistory.map((e) => e.total).reduce((a, b) => a + b) / rollHistory.length;
  int get maxRoll => rollHistory.isEmpty ? 0 : rollHistory.map((e) => e.total).reduce((a, b) => a > b ? a : b);
  int get minRoll => rollHistory.isEmpty ? 0 : rollHistory.map((e) => e.total).reduce((a, b) => a < b ? a : b);
}