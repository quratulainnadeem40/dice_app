import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final GetStorage _storage = GetStorage();

  static const String _soundKey = 'sound_enabled';
  static const String _vibrationKey = 'vibration_enabled';

  final soundEnabled = true.obs;
  final vibrationEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void _loadSettings() {
    soundEnabled.value =
        _storage.read<bool>(_soundKey) ?? true;

    vibrationEnabled.value =
        _storage.read<bool>(_vibrationKey) ?? true;
  }

  void toggleSound(bool value) {
    soundEnabled.value = value;
    _storage.write(_soundKey, value);
  }

  void toggleVibration(bool value) {
    vibrationEnabled.value = value;
    _storage.write(_vibrationKey, value);
  }

  void resetSettings() {
    soundEnabled.value = true;
    vibrationEnabled.value = true;

    _storage.write(_soundKey, true);
    _storage.write(_vibrationKey, true);
  }
}