import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class HomeController extends GetxController {
  final currentDice = 1.obs;
  final selectedBottomIndex = 0.obs;
  final isRolling = false.obs;

  final random = Random();
  late AudioPlayer _audioPlayer;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  // Pre-load audio asset for seamless playback
  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/dice_sound.mp3');
    } catch (e) {
      debugPrint('Audio initialization error: $e');
    }
  }

  // Dice roll with sound trigger
  Future<void> rollDice() async {
    if (isRolling.value) return;

    isRolling.value = true;

    try {
      // Re-play audio from beginning
      await _audioPlayer.seek(Duration.zero);
      _audioPlayer.play();
    } catch (e) {
      debugPrint('Audio playback error: $e');
    }

    // Rolling delay before changing value
    await Future.delayed(const Duration(milliseconds: 500));
    currentDice.value = random.nextInt(6) + 1;

    isRolling.value = false;
  }

  void changeBottomIndex(int index) {
    selectedBottomIndex.value = index;
  }

  @override
  void onClose() {
    _audioPlayer.dispose(); // Release audio resources
    super.onClose();
  }
}