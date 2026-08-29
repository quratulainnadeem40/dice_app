import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class VibrationService extends GetxService {
  final isVibrationEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> lightVibration() async {
    if (!isVibrationEnabled.value) return;
    
    try {
      await Vibration.vibrate(duration: 50);
    } catch (e) {
      print('Error vibrating: $e');
    }
  }

  Future<void> mediumVibration() async {
    if (!isVibrationEnabled.value) return;
    
    try {
      await Vibration.vibrate(duration: 100);
    } catch (e) {
      print('Error vibrating: $e');
    }
  }

  Future<void> heavyVibration() async {
    if (!isVibrationEnabled.value) return;
    
    try {
      await Vibration.vibrate(duration: 150);
    } catch (e) {
      print('Error vibrating: $e');
    }
  }

  Future<void> patternVibration() async {
    if (!isVibrationEnabled.value) return;
    
    try {
      await Vibration.vibrate(pattern: [0, 100, 100, 100]);
    } catch (e) {
      print('Error vibrating pattern: $e');
    }
  }

  Future<void> customVibration(int duration) async {
    if (!isVibrationEnabled.value) return;
    
    try {
      await Vibration.vibrate(duration: duration);
    } catch (e) {
      print('Error vibrating custom: $e');
    }
  }

  void toggleVibration() {
    isVibrationEnabled.toggle();
  }

  void setVibrationEnabled(bool enabled) {
    isVibrationEnabled.value = enabled;
  }

  Future<bool?> hasVibrator() async {
    return await Vibration.hasVibrator();
  }
}