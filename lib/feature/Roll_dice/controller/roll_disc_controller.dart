
import 'dart:math';

import 'package:dice_app/core/dice_theme.dart';
import 'package:dice_app/feature/history/controller/history_controller.dart';
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

  bool _isSpeaking = false;

  // ==========================================================
  // CONTROLLERS
  // ==========================================================

  late final SettingsController settingsController;

  late final HistoryController historyController;

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
  // INIT
  // ==========================================================

  @override
  void onInit() {
    super.onInit();

    // --------------------------------------------------------
    // SETTINGS CONTROLLER
    // --------------------------------------------------------

    if (Get.isRegistered<SettingsController>()) {
      settingsController = Get.find<SettingsController>();
    } else {
      settingsController = Get.put(
        SettingsController(),
      );
    }

    // --------------------------------------------------------
    // HISTORY CONTROLLER
    // --------------------------------------------------------

   if (Get.isRegistered<HistoryController>()) {
  historyController = Get.find<HistoryController>();
} else {
  historyController = Get.put(
    HistoryController(),
    permanent: true,
  );
}

    // --------------------------------------------------------
    // APPLY SETTINGS
    // --------------------------------------------------------

  // APPLY SETTINGS
applySettings();

// SETTINGS LISTENERS
ever(
  settingsController.diceSides,
  (int newSides) {
    diceSides.value = newSides;
    updateDiceCount();
  },
);

ever(
  settingsController.diceColor,
  (Color newColor) {
    updateThemeFromColor(newColor);
  },
);

ever(
  settingsController.diceCount,
  (int newCount) {
    playerCount.value = newCount.clamp(1, 7);
    updateDiceCount();
  },
);
    // --------------------------------------------------------
    // SETTINGS LISTENERS
    // --------------------------------------------------------

    ever(
      settingsController.diceSides,
      (int newSides) {
        diceSides.value = newSides;

        updateDiceCount();
      },
    );

    ever(
      settingsController.diceColor,
      (Color newColor) {
        updateThemeFromColor(newColor);
      },
    );

    // --------------------------------------------------------
    // SYNC SETTINGS
    // --------------------------------------------------------

    updateThemeFromColor(
      settingsController.diceColor.value,
    );

    updateDiceCount();

    // --------------------------------------------------------
    // VOICE
    // --------------------------------------------------------

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

      await flutterTts.awaitSpeakCompletion(true);
    } catch (e) {
      debugPrint(
        'Voice setup error: $e',
      );
    }
  }

  // ==========================================================
  // SPEAK DICE RESULTS
  // ==========================================================

  Future<void> speakDiceResults() async {
    if (_isSpeaking) {
      return;
    }

    if (diceValues.isEmpty) {
      return;
    }

    _isSpeaking = true;

    try {
      await flutterTts.stop();

      final int totalPlayers =
          diceValues.length.clamp(1, 7);

      for (
        int i = 0;
        i < totalPlayers;
        i++
      ) {
        final int playerNumber = i + 1;

        final int diceNumber =
            diceValues[i];

        final String sentence =
            'Player $playerNumber rolled '
            '${_numberToWord(diceNumber)}';

        await flutterTts.speak(
          sentence,
        );

        if (
          i < totalPlayers - 1
        ) {
          await Future.delayed(
            const Duration(
              milliseconds: 500,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint(
        'Voice error: $e',
      );
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
      debugPrint(
        'Stop voice error: $e',
      );
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

    return numbers[number] ??
        number.toString();
  }

  // ==========================================================
  // UPDATE DICE THEME
  // ==========================================================

  void updateThemeFromColor(Color color) {
  if (color == Colors.transparent) {
    // Multi-color mode
    selectedDiceTheme.value =
        DiceThemes.all.first;
    return;
  }

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
  playerCount.value = settingsController.diceCount.value.clamp(1, 7);

  diceSides.value = settingsController.diceSides.value;

  updateThemeFromColor(
    settingsController.diceColor.value,
  );

  updateDiceCount();
}

  // ==========================================================
  // PLAYER COUNT
  // ==========================================================

  void setPlayerCount(
    int count,
  ) {
    if (
      count < 1 ||
      count > 7
    ) {
      return;
    }

    stopVoice();

    playerCount.value = count;

    updateDiceCount();
  }

  // ==========================================================
  // DICE SIDES
  // ==========================================================

  void setDiceSides(
    int sides,
  ) {
    if (sides < 2) {
      return;
    }

    stopVoice();

    diceSides.value = sides;

    updateDiceCount();
  }

  // ==========================================================
  // DICE THEME
  // ==========================================================

  void setDiceTheme(
    DiceTheme theme,
  ) {
    selectedDiceTheme.value =
        theme;
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
  // SAVE RESULT TO HISTORY
  // ==========================================================

  void _saveToHistory(List<int> results) {
  if (results.isEmpty) {
    return;
  }

  historyController.addHistory(
    results: List<int>.from(results),
    playerCount: playerCount.value,
    diceSides: diceSides.value,
  );

  debugPrint(
    'History saved successfully: $results',
  );
}

  // ==========================================================
  // ROLL ALL DICE
  // ==========================================================

  Future<void> rollAllDice() async {
    if (isRolling.value) {
      return;
    }

    // --------------------------------------------------------
    // STOP PREVIOUS VOICE
    // --------------------------------------------------------

    await stopVoice();

    // --------------------------------------------------------
    // START ROLLING
    // --------------------------------------------------------

    isRolling.value = true;

    try {
      // ======================================================
      // ANIMATION SPEED
      // ======================================================

      final double speed =
          settingsController
              .animationSpeed
              .value;

      final int stepDelay =
          ((250 - (speed * 180)))
              .round()
              .clamp(
                30,
                250,
              );

      final int totalSteps =
          ((800 - (speed * 500)) /
                  stepDelay)
              .round()
              .clamp(
                4,
                12,
              );

      // ======================================================
      // DICE ANIMATION
      // ======================================================

      for (
        int i = 0;
        i < totalSteps;
        i++
      ) {
        await Future.delayed(
          Duration(
            milliseconds: stepDelay,
          ),
        );

        diceValues.assignAll(
          List.generate(
            playerCount.value,
            (_) {
              return _random.nextInt(
                    diceSides.value,
                  ) +
                  1;
            },
          ),
        );
      }

      // ======================================================
      // FINAL RESULTS
      // ======================================================

      final List<int> finalResults =
          List<int>.from(
        diceValues,
      );

      debugPrint(
        'Final Results: $finalResults',
      );

      // ======================================================
      // SAVE ONCE
      // ======================================================

      _saveToHistory(
        finalResults,
      );

      // ======================================================
      // ROLL FINISHED
      // ======================================================

      isRolling.value = false;

      // ======================================================
      // SPEAK FINAL RESULTS
      // ======================================================

      await speakDiceResults();
    } catch (e) {
      debugPrint(
        'Roll error: $e',
      );

      isRolling.value = false;
    }
  }

  // ==========================================================
  // CLEAR HISTORY
  // ==========================================================

  void clearHistory() {
    historyController.clearHistory();

    debugPrint(
      'History cleared',
    );
  }

  // ==========================================================
  // REMOVE ONE HISTORY ITEM
  // ==========================================================

  void removeHistoryItem(
    int index,
  ) {
    historyController.removeHistory(
      index,
    );
  }

  // ==========================================================
  // CLEANUP
  // ==========================================================

  @override
  void onClose() {
    _isSpeaking = false;

    flutterTts.stop();

    super.onClose();
  }
}