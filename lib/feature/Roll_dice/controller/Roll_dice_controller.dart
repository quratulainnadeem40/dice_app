

import 'dart:math';

import 'package:dice_app/core/dice_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class RollDiceController extends GetxController {
  final Random _random = Random();
  final FlutterTts _tts = FlutterTts();

  // ==========================================================
  // CONSTANTS
  // ==========================================================

  static const int maxPlayers = 7;
  static const int minDiceSides = 3;
  static const int maxDiceSides = 100;

  // ==========================================================
  // PLAYER / DICE STATE
  // ==========================================================

  final playerCount = 1.obs;

  final diceValues = <int>[1].obs;

  final isRolling = false.obs;

  // ==========================================================
  // DICE SETTINGS
  // ==========================================================

  final diceSides = 6.obs;

  final diceTheme = 'purple'.obs;

  final animationSpeed = 'normal'.obs;

  // ==========================================================
  // SELECTED DICE THEME
  // ==========================================================

  DiceTheme get selectedDiceTheme {
    return DiceThemes.getById(
      diceTheme.value,
    );
  }

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void onInit() {
    super.onInit();

    updateDiceCount();

    _initVoice();
  }

  // ==========================================================
  // VOICE INITIALIZATION
  // ==========================================================

  Future<void> _initVoice() async {
    try {
      await _tts.setLanguage('en-US');

      await _tts.setSpeechRate(0.48);

      await _tts.setPitch(1.0);

      await _tts.setVolume(1.0);
    } catch (_) {
      // Ignore TTS initialization errors.
    }
  }

  // ==========================================================
  // PLAYER COUNT
  // ==========================================================

  void setPlayerCount(int count) {
    if (count < 1 || count > maxPlayers) {
      return;
    }

    playerCount.value = count;

    updateDiceCount();
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
  // DICE SIDES
  // ==========================================================

  void setDiceSides(int sides) {
    if (sides < minDiceSides ||
        sides > maxDiceSides) {
      return;
    }

    diceSides.value = sides;

    diceValues.assignAll(
      diceValues.map(
        (value) {
          return value > sides ? 1 : value;
        },
      ),
    );
  }

  // ==========================================================
  // DICE THEME
  // ==========================================================

  void setDiceTheme(String theme) {
    final exists = DiceThemes.all.any(
      (item) => item.id == theme,
    );

    if (!exists) {
      return;
    }

    diceTheme.value = theme;
  }

  // ==========================================================
  // ANIMATION SPEED
  // ==========================================================

  void setAnimationSpeed(String speed) {
    const validSpeeds = [
      'slow',
      'normal',
      'fast',
    ];

    if (!validSpeeds.contains(speed)) {
      return;
    }

    animationSpeed.value = speed;
  }

  // ==========================================================
  // ANIMATION DURATION
  // ==========================================================

  int get animationDuration {
    switch (animationSpeed.value) {
      case 'slow':
        return 900;

      case 'fast':
        return 250;

      case 'normal':
      default:
        return 500;
    }
  }

  // ==========================================================
  // ROLL ALL DICE
  // ==========================================================

  Future<void> rollAllDice() async {
  if (isRolling.value) {
    return;
  }

  isRolling.value = true;

  try {
    await _vibrateStart();

    // Number of visual changes during the roll.
    const int rollSteps = 8;

    // Total animation time is divided between the steps.
    final int stepDuration =
        animationDuration ~/ rollSteps;

    for (int step = 0; step < rollSteps; step++) {
      // Generate temporary random values.
      final temporaryValues = List.generate(
        playerCount.value,
        (_) => _random.nextInt(
              diceSides.value,
            ) +
            1,
      );

      diceValues.assignAll(temporaryValues);

      await Future.delayed(
        Duration(
          milliseconds: stepDuration,
        ),
      );
    }

    // Final result.
    final results = List.generate(
      playerCount.value,
      (_) => _random.nextInt(
            diceSides.value,
          ) +
          1,
    );

    diceValues.assignAll(results);

    await _vibrateResult();

    await _speakResults(results);
  } catch (_) {
    // Keep the UI stable if a device feature fails.
  } finally {
    isRolling.value = false;
  }
}


  // ==========================================================
  // START VIBRATION
  // ==========================================================

  Future<void> _vibrateStart() async {
    try {
      final hasVibrator =
          await Vibration.hasVibrator();

      if (hasVibrator) {
        await Vibration.vibrate(
          duration: 70,
        );
      } else {
        await HapticFeedback.lightImpact();
      }
    } catch (_) {
      try {
        await HapticFeedback.lightImpact();
      } catch (_) {}
    }
  }

  // ==========================================================
  // RESULT VIBRATION
  // ==========================================================

  Future<void> _vibrateResult() async {
    try {
      final hasVibrator =
          await Vibration.hasVibrator();

      if (hasVibrator) {
        await Vibration.vibrate(
          duration: 110,
        );
      } else {
        await HapticFeedback.mediumImpact();
      }
    } catch (_) {
      try {
        await HapticFeedback.mediumImpact();
      } catch (_) {}
    }
  }

  // ==========================================================
  // SPEAK RESULTS
  // ==========================================================

  Future<void> _speakResults(
    List<int> results,
  ) async {
    if (results.isEmpty) {
      return;
    }

    try {
      await _tts.stop();

      String message;

      if (results.length == 1) {
        message =
            'You rolled ${results.first}.';
      } else {
        final parts = <String>[];

        for (
          int i = 0;
          i < results.length;
          i++
        ) {
          parts.add(
            'Player ${i + 1} rolled ${results[i]}',
          );
        }

        message =
            '${parts.join('. ')}.';
      }

      await _tts.speak(message);
    } catch (_) {
      // Ignore TTS errors.
    }
  }

  // ==========================================================
  // CLEANUP
  // ==========================================================

  @override
  void onClose() {
    _tts.stop();

    super.onClose();
  }
}