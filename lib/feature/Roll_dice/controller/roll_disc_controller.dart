
import 'dart:math';

import 'package:dice_app/core/dice_theme.dart';
import 'package:dice_app/feature/history/controller/history_controller.dart';
import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vibration/vibration.dart';

class RollDiceController extends GetxController {
  final Random _random = Random();

  // ==========================================================
  // VOICE
  // ==========================================================

  final FlutterTts flutterTts = FlutterTts();

  bool _isSpeaking = false;

  // ==========================================================
  // DICE ROLL SOUND
  // ==========================================================

  final AudioPlayer _audioPlayer = AudioPlayer();

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

  final RxList<int> diceValues = <int>[1].obs;

  final isRolling = false.obs;

  // ==========================================================
  // PLAYER NAMES
  // ==========================================================

  final RxList<String> playerNames = <String>[].obs;

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
    // APPLY CURRENT SETTINGS
    // --------------------------------------------------------

    applySettings();

    // --------------------------------------------------------
// LISTEN ONLY TO SAVED SETTINGS
// --------------------------------------------------------

ever<int>(
  settingsController.settingsVersion,
  (_) {
    applySettings();
  },
);

    // --------------------------------------------------------
    // SYNC SETTINGS
    // --------------------------------------------------------

    updateThemeFromColor(
      settingsController.diceColor.value,
    );

    updatePlayerNames();

    updateDiceCount();

    // --------------------------------------------------------
    // VOICE
    // --------------------------------------------------------

    _setupVoice();

    // --------------------------------------------------------
    // SOUND
    // --------------------------------------------------------

    _setupSound();
  }

  int _speechSessionId = 0;

  // ==========================================================
  // VOICE SETUP
  // ==========================================================

  Future<void> _setupVoice() async {
    try {
      await flutterTts.setLanguage('en-US');
      await flutterTts.setSpeechRate(0.58);
      await flutterTts.setVolume(
        settingsController.settings.soundVolume.clamp(0.0, 1.0),
      );
      await flutterTts.setPitch(1.0);
    } catch (e) {
      debugPrint('Voice setup error: $e');
    }
  }

  // ==========================================================
  // SOUND SETUP
  // ==========================================================

 Future<void> _setupSound() async {
  try {
    await _audioPlayer.setAsset(
      'assets/sounds/dice_sound.mp3',
    );

    await _audioPlayer.setVolume(
      settingsController.settings.soundVolume,
    );
  } catch (e) {
    debugPrint(
      'Sound setup error: $e',
    );
  }
}

  // ==========================================================
  // TOGGLE SOUND (QUICK ACTION)
  // ==========================================================

  void toggleSound() {
    final bool current = settingsController.soundEnabled.value;
    final bool newValue = !current;
    settingsController.soundEnabled.value = newValue;
    settingsController.settings.soundEnabled = newValue;
    settingsController.settingsVersion.value++;
    if (!newValue) {
      stopVoice();
      _stopDiceSound();
    }
  }

  // ==========================================================
  // PLAY DICE SOUND
  // ==========================================================

  Future<void> _playDiceSound() async {
   if (!settingsController.settings.soundEnabled) {
      return;
    }

    try {
   final double volume =
    settingsController.settings.soundVolume
        .clamp(0.0, 1.0);
      await _audioPlayer.setVolume(volume);

      await _audioPlayer.seek(
        Duration.zero,
      );

      await _audioPlayer.play();
    } catch (e) {
      debugPrint(
        'Dice sound error: $e',
      );
    }
  }

  // ==========================================================
  // STOP DICE SOUND
  // ==========================================================

  Future<void> _stopDiceSound() async {
    try {
      await _audioPlayer.stop();
    } catch (e) {
      debugPrint(
        'Stop dice sound error: $e',
      );
    }
  }

  bool? _hasVibratorCached;

  // ==========================================================
  // VIBRATION (PERFECTLY SYNCHRONIZED WITH ROLL TIMING)
  // ==========================================================

  Future<bool> _checkVibrator() async {
    if (_hasVibratorCached != null) return _hasVibratorCached!;
    try {
      _hasVibratorCached = await Vibration.hasVibrator();
    } catch (_) {
      _hasVibratorCached = false;
    }
    return _hasVibratorCached ?? false;
  }

  void _triggerRollVibration({
    required int totalDurationMs,
    required int stepDelay,
  }) {
    if (!settingsController.settings.vibrationEnabled) {
      return;
    }

    final double intensity =
        settingsController.settings.vibrationIntensity.clamp(0.0, 1.0);
    if (intensity <= 0) {
      return;
    }

    _checkVibrator().then((hasVib) {
      if (!hasVib) return;

      final int pulseOn = (stepDelay * 0.40).round().clamp(14, 30);
      final int pulseOff = (stepDelay * 0.60).round().clamp(16, 40);
      final int stepCount =
          (totalDurationMs / (pulseOn + pulseOff)).floor().clamp(3, 10);

      final List<int> pattern = [];
      final List<int> intensities = [];

      for (int i = 0; i < stepCount; i++) {
        pattern.add(i == 0 ? 0 : pulseOff);
        pattern.add(pulseOn);

        final double factor = 0.5 + (0.5 * (i / stepCount));
        intensities.add(((intensity * factor) * 255).round().clamp(1, 255));
      }

      // Crisp landing tap matching dice stop
      pattern.add(pulseOff);
      pattern.add((35 * intensity).round().clamp(20, 55));
      intensities.add((intensity * 255).round().clamp(1, 255));

      Vibration.vibrate(
        pattern: pattern,
        intensities: intensities,
      ).catchError((_) {
        Vibration.vibrate(duration: totalDurationMs).catchError((_) {});
      });
    }).catchError((_) {});
  }

  // ==========================================================
  // SPEAK DICE RESULTS
  // ==========================================================

  Future<void> speakDiceResults() async {
    if (!settingsController.settings.soundEnabled) {
      return;
    }

    final double volume =
        settingsController.settings.soundVolume.clamp(0.0, 1.0);
    if (volume <= 0.0) {
      return;
    }

    if (diceValues.isEmpty) {
      return;
    }

    final int currentSession = ++_speechSessionId;
    _isSpeaking = true;

    try {
      await flutterTts.stop();
      await flutterTts.setVolume(volume);
      await flutterTts.setSpeechRate(0.58);
      await flutterTts.setPitch(1.0);

      final int totalPlayers =
          diceValues.length.clamp(1, 7);

      if (_speechSessionId != currentSession) {
        return;
      }

      if (totalPlayers == 1) {
        final int diceNumber = diceValues[0];
        final String sentence = _numberToWord(diceNumber);
        await flutterTts.speak(sentence);
      } else {
        final List<String> playerParts = [];
        for (int i = 0; i < totalPlayers; i++) {
          final int diceNumber = diceValues[i];
          final String playerName =
              i < playerNames.length
                  ? playerNames[i]
                  : 'Player ${i + 1}';

          playerParts.add(
            '$playerName: ${_numberToWord(diceNumber)}',
          );
        }

        final String sentence = playerParts.join('. ');
        await flutterTts.speak(sentence);
      }
    } catch (e) {
      debugPrint(
        'Voice error: $e',
      );
    } finally {
      if (_speechSessionId == currentSession) {
        _isSpeaking = false;
      }
    }
  }

  // ==========================================================
  // STOP VOICE
  // ==========================================================

  Future<void> stopVoice() async {
    _speechSessionId++;
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
      selectedDiceTheme.value =
          DiceThemes.all.first;
      return;
    }

    selectedDiceTheme.value =
        DiceTheme(
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
  playerCount.value =
      settingsController.settings.diceCount.clamp(1, 8);

  diceSides.value =
      settingsController.settings.diceSides;

  updateThemeFromColor(
    settingsController.settings.diceColor,
  );

  updatePlayerNames();

  updateDiceCount();
}

  // ==========================================================
  // UPDATE PLAYER NAMES
  // ==========================================================

  void updatePlayerNames() {
    final List<String> oldNames =
        List<String>.from(playerNames);

    final List<String> newNames =
        List.generate(
      playerCount.value,
      (index) {
        if (index < oldNames.length &&
            oldNames[index]
                .trim()
                .isNotEmpty) {
          return oldNames[index];
        }

        return 'Player ${index + 1}';
      },
    );

    playerNames.assignAll(
      newNames,
    );
  }

  // ==========================================================
  // SET PLAYER NAME
  // ==========================================================

  void setPlayerName(
    int index,
    String name,
  ) {
    if (index < 0 ||
        index >= playerNames.length) {
      return;
    }

    final String trimmedName =
        name.trim();

    if (trimmedName.isEmpty) {
      playerNames[index] =
          'Player ${index + 1}';
    } else {
      playerNames[index] =
          trimmedName;
    }

    playerNames.refresh();
  }

  // ==========================================================
  // GET PLAYER NAME
  // ==========================================================

  String getPlayerName(int index) {
    if (index < 0 ||
        index >= playerNames.length) {
      return 'Player ${index + 1}';
    }

    final String name =
        playerNames[index].trim();

    if (name.isEmpty) {
      return 'Player ${index + 1}';
    }

    return name;
  }

  // ==========================================================
  // EDIT PLAYER NAME
  // ==========================================================
Future<void> editPlayerName(
  BuildContext context,
  int index,
) async {
  if (index < 0 || index >= playerNames.length) {
    return;
  }

  final TextEditingController textController =
      TextEditingController(
    text: getPlayerName(index),
  );

  final String? newName = await showDialog<String>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        backgroundColor: const Color(0xFF111437),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Text(
          'Edit Player Name',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: TextField(
          controller: textController,
          autofocus: true,
          maxLength: 20,
          textCapitalization: TextCapitalization.words,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter player name',
            hintStyle: TextStyle(
              color: Colors.white.withValues(
                alpha: 0.4,
              ),
            ),
            counterStyle: TextStyle(
              color: Colors.white.withValues(
                alpha: 0.4,
              ),
            ),
            filled: true,
            fillColor: Colors.white.withValues(
              alpha: 0.06,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(
                textController.text.trim(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B22E9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      );
    },
  );

 if (newName != null && newName.isNotEmpty) {
  await Future<void>.delayed(Duration.zero);
  setPlayerName(index, newName);
}
}

// ==========================================================
// PLAYER COUNT
// ==========================================================

void setPlayerCount(
    int count,
  ) {
    if (count < 1 ||
        count > 8) {
      return;
    }

    stopVoice();

    playerCount.value =
        count;

    updatePlayerNames();
    updateDiceCount();
  }

  // ==========================================================
  // DICE SIDES
  // ==========================================================

  void setDiceSides(
    int sides,
  ) {
    if (sides < 3 ||
        sides > 20) {
      return;
    }

    stopVoice();

    diceSides.value =
        sides;

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
    final int count =
        playerCount.value
            .clamp(1, 7);

    diceValues.assignAll(
      List.generate(
        count,
        (_) => 1,
      ),
    );

    final List<String> oldNames =
        List<String>.from(
      playerNames,
    );

    playerNames.assignAll(
      List.generate(
        count,
        (index) {
          if (index <
                  oldNames.length &&
              oldNames[index]
                  .trim()
                  .isNotEmpty) {
            return oldNames[index];
          }

          return 'Player ${index + 1}';
        },
      ),
    );
  }

  // ==========================================================
  // SAVE RESULT TO HISTORY
  // ==========================================================

  void _saveToHistory(
    List<int> results,
  ) {
    if (results.isEmpty) {
      return;
    }

    historyController.addHistory(
      results:
          List<int>.from(results),
      playerCount:
          playerCount.value,
      diceSides:
          diceSides.value,
    );

    debugPrint(
      'History saved successfully: '
      '$results',
    );
  }

  // ==========================================================
  // ROLL ALL DICE
  // ==========================================================

  Future<void> rollAllDice() async {
    if (isRolling.value) {
      return;
    }

    await stopVoice();
    await _stopDiceSound();

    isRolling.value = true;

    try {
      final double speed =
          settingsController.settings.animationSpeed.clamp(0.0, 1.0);
      final int stepDelay = (65 - (speed * 30)).round().clamp(30, 70);
      final int totalDurationMs =
          (850 - (speed * 400)).round().clamp(450, 900);
      final int totalSteps = (totalDurationMs / stepDelay).round();

      // Trigger roll sound and perfectly matched haptic vibration
      _playDiceSound();
      _triggerRollVibration(
        totalDurationMs: totalDurationMs,
        stepDelay: stepDelay,
      );

      for (int i = 0; i < totalSteps; i++) {
        await Future.delayed(
          Duration(milliseconds: stepDelay),
        );

        if (!isRolling.value) break;

        diceValues.assignAll(
          List.generate(
            playerCount.value,
            (_) => _random.nextInt(diceSides.value) + 1,
          ),
        );
      }

      final List<int> finalResults = List.generate(
        playerCount.value,
        (_) => _random.nextInt(diceSides.value) + 1,
      );
      diceValues.assignAll(finalResults);

      debugPrint('Final Results: $finalResults');
      _saveToHistory(finalResults);

      isRolling.value = false;
      await _stopDiceSound();

      await Future.delayed(
        const Duration(
          milliseconds: 140,
        ),
      );

      await speakDiceResults();
    } catch (e) {
      debugPrint(
        'Roll error: $e',
      );

      isRolling.value =
          false;

      await _stopDiceSound();
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
  // REMOVE HISTORY ITEM
  // ==========================================================

  void removeHistoryItem(
    int index,
  ) {
    historyController
        .removeHistory(index);
  }

  // ==========================================================
  // CLEANUP
  // ==========================================================

  @override
  void onClose() {
    _isSpeaking = false;

    flutterTts.stop();

    _audioPlayer.dispose();

    super.onClose();
  }
}