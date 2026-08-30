
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
    // LISTEN TO DICE SIDES
    // --------------------------------------------------------

    ever<int>(
      settingsController.diceSides,
      (int newSides) {
        diceSides.value = newSides;
        updateDiceCount();
      },
    );

    // --------------------------------------------------------
    // LISTEN TO DICE COLOR
    // --------------------------------------------------------

    ever<Color>(
      settingsController.diceColor,
      (Color newColor) {
        updateThemeFromColor(newColor);
      },
    );

    // --------------------------------------------------------
    // LISTEN TO DICE COUNT
    // --------------------------------------------------------

    ever<int>(
      settingsController.diceCount,
      (int newCount) {
        final int count = newCount.clamp(1, 7);

        playerCount.value = count;

        updatePlayerNames();
        updateDiceCount();
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
        settingsController.soundVolume.value,
      );

      // Listen for volume changes.
      ever<double>(
        settingsController.soundVolume,
        (double volume) async {
          try {
            await _audioPlayer.setVolume(
              volume.clamp(0.0, 1.0),
            );
          } catch (e) {
            debugPrint(
              'Sound volume error: $e',
            );
          }
        },
      );
    } catch (e) {
      debugPrint(
        'Sound setup error: $e',
      );
    }
  }

  // ==========================================================
  // PLAY DICE SOUND
  // ==========================================================

  Future<void> _playDiceSound() async {
    if (!settingsController.soundEnabled.value) {
      return;
    }

    try {
      final double volume =
          settingsController.soundVolume.value
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

  // ==========================================================
  // VIBRATION
  // ==========================================================

  Future<void> _vibrate() async {
    if (!settingsController.vibrationEnabled.value) {
      return;
    }

    try {
      final bool hasVibrator =
          await Vibration.hasVibrator();

      if (!hasVibrator) {
        return;
      }

      final double intensity =
          settingsController.vibrationIntensity.value
              .clamp(0.0, 1.0);

      if (intensity <= 0) {
        return;
      }

      final int duration =
          (20 + (intensity * 80)).round();

      await Vibration.vibrate(
        duration: duration,
      );
    } catch (e) {
      debugPrint(
        'Vibration error: $e',
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

      for (int i = 0; i < totalPlayers; i++) {
        final String playerName =
            i < playerNames.length
                ? playerNames[i]
                : 'Player ${i + 1}';

        final int diceNumber =
            diceValues[i];

        final String sentence =
            '$playerName rolled '
            '${_numberToWord(diceNumber)}';

        await flutterTts.speak(
          sentence,
        );

        if (i < totalPlayers - 1) {
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
        settingsController.diceCount.value
            .clamp(1, 7);

    diceSides.value =
        settingsController.diceSides.value;

    updateThemeFromColor(
      settingsController.diceColor.value,
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
    if (index < 0 ||
        index >= playerNames.length) {
      return;
    }

    final TextEditingController
        textController =
        TextEditingController(
      text: getPlayerName(index),
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF111437),
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(18),
          ),
          title: const Text(
            'Edit Player Name',
            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.w800,
            ),
          ),
          content: TextField(
            controller:
                textController,
            autofocus: true,
            maxLength: 20,
            textCapitalization:
                TextCapitalization.words,
            style:
                const TextStyle(
              color: Colors.white,
            ),
            decoration:
                InputDecoration(
              hintText:
                  'Enter player name',
              hintStyle:
                  TextStyle(
                color: Colors.white
                    .withValues(
                  alpha: 0.4,
                ),
              ),
              counterStyle:
                  TextStyle(
                color: Colors.white
                    .withValues(
                  alpha: 0.4,
                ),
              ),
              filled: true,
              fillColor: Colors.white
                  .withValues(
                alpha: 0.06,
              ),
              border:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
                borderSide:
                    BorderSide.none,
              ),
            ),
            onSubmitted: (_) {
              setPlayerName(
                index,
                textController.text,
              );

              Navigator.of(
                dialogContext,
              ).pop();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(
                  dialogContext,
                ).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color:
                      Colors.white70,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setPlayerName(
                  index,
                  textController.text,
                );

                Navigator.of(
                  dialogContext,
                ).pop();
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF8B22E9,
                ),
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),
                ),
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );

    textController.dispose();
  }

  // ==========================================================
  // PLAYER COUNT
  // ==========================================================

  void setPlayerCount(
    int count,
  ) {
    if (count < 1 ||
        count > 7) {
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
      // ------------------------------------------------------
      // ANIMATION SPEED
      // ------------------------------------------------------

      final double speed =
          settingsController
              .animationSpeed
              .value
              .clamp(0.0, 1.0);

      final int stepDelay =
          ((250 -
                  (speed * 180)))
              .round()
              .clamp(
                30,
                250,
              );

      final int totalSteps =
          ((800 -
                      (speed * 500)) /
                  stepDelay)
              .round()
              .clamp(
                4,
                12,
              );

      // ------------------------------------------------------
      // START SOUND
      // ------------------------------------------------------

      await _playDiceSound();

      // ------------------------------------------------------
      // DICE ANIMATION
      // ------------------------------------------------------

      for (
        int i = 0;
        i < totalSteps;
        i++
      ) {
        await Future.delayed(
          Duration(
            milliseconds:
                stepDelay,
          ),
        );

        // Vibration on every animation step.
        await _vibrate();

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

      // ------------------------------------------------------
      // FINAL RESULTS
      // ------------------------------------------------------

      final List<int> finalResults =
          List<int>.from(
        diceValues,
      );

      debugPrint(
        'Final Results: '
        '$finalResults',
      );

      // ------------------------------------------------------
      // SAVE TO HISTORY
      // ------------------------------------------------------

      _saveToHistory(
        finalResults,
      );

      // ------------------------------------------------------
      // ROLL FINISHED
      // ------------------------------------------------------

      isRolling.value =
          false;

      // ------------------------------------------------------
      // STOP ROLL SOUND
      // ------------------------------------------------------

      await _stopDiceSound();

      // ------------------------------------------------------
      // SPEAK RESULTS
      // ------------------------------------------------------

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