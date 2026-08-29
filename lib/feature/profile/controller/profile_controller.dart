import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final GetStorage _storage = GetStorage();

  // Storage keys
  static const String _nameKey = 'player_name';
  static const String _soundKey = 'sound_enabled';
  static const String _vibrationKey = 'vibration_enabled';

  // Profile
  final playerName = 'Dice Player'.obs;

  // Statistics
  final totalRolls = 0.obs;
  final bestRoll = 0.obs;
  final averageRoll = 0.0.obs;

  // Settings
  final soundEnabled = true.obs;
  final vibrationEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();

    _loadProfileData();
  }

  // ================================================================
  // LOAD SAVED DATA
  // ================================================================

  void _loadProfileData() {
    playerName.value =
        _storage.read<String>(_nameKey) ?? 'Dice Player';

    soundEnabled.value =
        _storage.read<bool>(_soundKey) ?? true;

    vibrationEnabled.value =
        _storage.read<bool>(_vibrationKey) ?? true;
  }

  // ================================================================
  // UPDATE NAME
  // ================================================================

  void updatePlayerName(String name) {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return;
    }

    playerName.value = trimmedName;

    _storage.write(
      _nameKey,
      trimmedName,
    );
  }

  // ================================================================
  // SOUND
  // ================================================================

  void toggleSound(bool value) {
    soundEnabled.value = value;

    _storage.write(
      _soundKey,
      value,
    );
  }

  // ================================================================
  // VIBRATION
  // ================================================================

  void toggleVibration(bool value) {
    vibrationEnabled.value = value;

    _storage.write(
      _vibrationKey,
      value,
    );
  }
}