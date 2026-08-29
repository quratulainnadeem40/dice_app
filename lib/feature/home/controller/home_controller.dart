import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  final stats = HomeStats.empty().obs;
  final recentRolls = <RecentRoll>[].obs;
  final achievements = <Achievement>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    // Initialize with default stats
    stats.value = HomeStats(
      totalRolls: 15,
      lastResult: 6,
      maxRoll: 6,
      minRoll: 1,
    );

    // Add some recent rolls
    recentRolls.addAll([
      RecentRoll(
        result: 6,
        timestamp: DateTime.now(),
        diceCount: 1,
        diceSides: 6,
      ),
      RecentRoll(
        result: 4,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        diceCount: 1,
        diceSides: 6,
      ),
    ]);

    // Initialize achievements
    achievements.addAll([
      Achievement(
        id: 'first_roll',
        title: 'First Roll',
        description: 'Roll the dice for the first time',
        icon: '🎲',
        isUnlocked: true,
        progress: 1.0,
      ),
      Achievement(
        id: 'rolling_star',
        title: 'Rolling Star',
        description: 'Roll 100 times',
        icon: '⭐',
        isUnlocked: false,
        progress: 0.15,
      ),
    ]);
  }

  void goToRoll() {
    Get.toNamed(AppRoutes.rollDice);
  }

  void goToQuickRoll() {
    Get.toNamed(AppRoutes.rollDice);
  }

  void goToHistory() {
    Get.toNamed(AppRoutes.history);
  }

  void goToAchievements() {
    Get.toNamed(AppRoutes.achievements);
  }

  void goToMultiplayer() {
    Get.toNamed(AppRoutes.multiplayer);
  }
}