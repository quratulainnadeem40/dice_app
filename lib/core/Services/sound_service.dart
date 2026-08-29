import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SoundService extends GetxService {
  late AudioPlayer _audioPlayer;
  final isSoundEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
  }

  Future<void> playDiceRollSound() async {
    if (!isSoundEnabled.value) return;
    
    try {
      await _audioPlayer.setAsset('assets/sounds/dice_roll.mp3');
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing dice roll sound: $e');
    }
  }

  Future<void> playClickSound() async {
    if (!isSoundEnabled.value) return;
    
    try {
      await _audioPlayer.setAsset('assets/sounds/click.mp3');
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing click sound: $e');
    }
  }

  Future<void> playWinSound() async {
    if (!isSoundEnabled.value) return;
    
    try {
      await _audioPlayer.setAsset('assets/sounds/win.mp3');
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing win sound: $e');
    }
  }

  void toggleSound() {
    isSoundEnabled.toggle();
  }

  void setSoundEnabled(bool enabled) {
    isSoundEnabled.value = enabled;
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}