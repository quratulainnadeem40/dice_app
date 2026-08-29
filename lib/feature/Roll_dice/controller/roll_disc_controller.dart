
import 'dart:math';

import 'package:dice_app/core/dice_theme.dart';
import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class RollDiceController extends GetxController {
  final Random _random = Random();

  // ==========================================================
  // VOICE
  // ==========================================================

  final FlutterTts flutterTts = FlutterTts();

  // Prevent voice from being triggered multiple times
  bool _isSpeaking = false;

  // Settings Controller reference safely handled
  late final SettingsController settingsController;

  // ==========================================================
  // REACTIVE VARIABLES
  // ==========================================================

  final playerCount = 1.obs;
  final diceSides = 6.obs;

  final Rx<DiceTheme> selectedDiceTheme =
      DiceThemes.all.first.obs;

  final diceValues = <int>[1].obs;

  final isRolling = false.obs;

  // ==========================================================
  // ON INIT
  // ==========================================================

  @override
  void onInit() {
    super.onInit();

    // Safe Initialization check
    if (Get.isRegistered<SettingsController>()) {
      settingsController = Get.find<SettingsController>();
    } else {
      settingsController = Get.put(SettingsController());
    }

    applySettings();

    // ========================================================
    // SETTINGS LISTENERS
    // ========================================================

    ever(settingsController.diceSides, (int newSides) {
      diceSides.value = newSides;
      updateDiceCount();
    });

    ever(settingsController.diceColor, (Color newColor) {
      updateThemeFromColor(newColor);
    });

    // ========================================================
    // SYNC SETTINGS ON START
    // ========================================================

    updateThemeFromColor(
      settingsController.diceColor.value,
    );

    updateDiceCount();

    // ========================================================
    // VOICE SETUP
    // ========================================================

    _setupVoice();
  }

  // ==========================================================
  // VOICE SETUP
  // ==========================================================

  Future<void> _setupVoice() async {
    try {
      await flutterTts.setLanguage('en-US');

      await flutterTts.setSpeechRate(0.48);

      await flutterTts.setVolume(1.0);

      await flutterTts.setPitch(1.0);

      // Make sure every sentence finishes before next one
      await flutterTts.awaitSpeakCompletion(true);
    } catch (e) {
      debugPrint('Voice setup error: $e');
    }
  }

  // ==========================================================
  // SPEAK ALL PLAYERS + DICE RESULTS
  // ==========================================================

  Future<void> speakDiceResults() async {
    if (_isSpeaking) return;

    if (diceValues.isEmpty) return;

    _isSpeaking = true;

    try {
      // Stop any previous voice
      await flutterTts.stop();

      // Make sure current player count and dice list match
      final int totalPlayers = diceValues.length.clamp(1, 7);

      for (int i = 0; i < totalPlayers; i++) {
        final int playerNumber = i + 1;
        final int diceNumber = diceValues[i];

        final String sentence =
            'Player $playerNumber rolled ${_numberToWord(diceNumber)}';

        // Speak one player result
        await flutterTts.speak(sentence);

        // Small pause before next player
        if (i < totalPlayers - 1) {
          await Future.delayed(
            const Duration(milliseconds: 500),
          );
        }
      }
    } catch (e) {
      debugPrint('Voice error: $e');
    } finally {
      _isSpeaking = false;
    }
  }

  // ==========================================================
  // STOP VOICE
  // ==========================================================

  Future<void> stopVoice() async {
    _isSpeaking = false;

    try {
      await flutterTts.stop();
    } catch (e) {
      debugPrint('Stop voice error: $e');
    }
  }

  // ==========================================================
  // NUMBER TO WORD
  // ==========================================================

  String _numberToWord(int number) {
    const Map<int, String> numbers = {
      1: 'One',
      2: 'Two',
      3: 'Three',
      4: 'Four',
      5: 'Five',
      6: 'Six',
      7: 'Seven',
      8: 'Eight',
      9: 'Nine',
      10: 'Ten',
      11: 'Eleven',
      12: 'Twelve',
      13: 'Thirteen',
      14: 'Fourteen',
      15: 'Fifteen',
      16: 'Sixteen',
      17: 'Seventeen',
      18: 'Eighteen',
      19: 'Nineteen',
      20: 'Twenty',
    };

    return numbers[number] ?? number.toString();
  }

  // ==========================================================
  // MAP SELECTED COLOR TO DICE THEME
  // ==========================================================

  void updateThemeFromColor(Color color) {
    selectedDiceTheme.value = DiceTheme(
      id: 'custom_theme_${color.value}',
      name: 'Custom Theme',
      colors: [
        color,
        color.withValues(alpha: 0.7),
      ],
      glowColor: color,
    );
  }

  // ==========================================================
  // APPLY SETTINGS
  // ==========================================================

  void applySettings() {
    diceSides.value =
        settingsController.diceSides.value;
  }

  // ==========================================================
  // PLAYER COUNT
  // ==========================================================

  void setPlayerCount(int count) {
    if (count < 1 || count > 7) return;

    // Stop voice if player count changes
    stopVoice();

    playerCount.value = count;

    updateDiceCount();
  }

  // ==========================================================
  // DICE SIDES
  // ==========================================================

  void setDiceSides(int sides) {
    if (sides < 2) return;

    // Stop voice if dice type changes
    stopVoice();

    diceSides.value = sides;

    updateDiceCount();
  }

  // ==========================================================
  // DICE THEME
  // ==========================================================

  void setDiceTheme(DiceTheme theme) {
    selectedDiceTheme.value = theme;
  }

  // ==========================================================
  // UPDATE DICE COUNT
  // ==========================================================

  void updateDiceCount() {
    diceValues.assignAll(
      List.generate(
        playerCount.value,
        (_) => 1,
      ),
    );
  }

  // ==========================================================
  // FAST & DYNAMIC ROLL LOGIC
  // ==========================================================

  Future<void> rollAllDice() async {
    if (isRolling.value) return;

    // Stop previous voice
    await stopVoice();

    isRolling.value = true;

    final double speed =
        settingsController.animationSpeed.value;

    final int stepDelay =
        ((250 - (speed * 180)))
            .round()
            .clamp(30, 250);

    final int totalSteps =
        ((800 - (speed * 500)) / stepDelay)
            .round()
            .clamp(4, 12);

    // ========================================================
    // DICE ANIMATION
    // ========================================================

    for (int i = 0; i < totalSteps; i++) {
      await Future.delayed(
        Duration(milliseconds: stepDelay),
      );

      diceValues.assignAll(
        List.generate(
          playerCount.value,
          (_) =>
              _random.nextInt(diceSides.value) + 1,
        ),
      );
    }

    // ========================================================
    // ROLL FINISHED
    // ========================================================

    isRolling.value = false;

    // ========================================================
    // SPEAK FINAL RESULTS
    // ========================================================

    await speakDiceResults();
  }

  // ==========================================================
  // CLEANUP VOICE
  // ==========================================================

  @override
  void onClose() {
    _isSpeaking = false;

    flutterTts.stop();

    super.onClose();
  }
}

