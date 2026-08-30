import 'dart:async';
import 'dart:math';

import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/core/theme/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DiceCard extends StatefulWidget {
  const DiceCard({super.key});

  @override
  State<DiceCard> createState() => _DiceCardState();
}

class _DiceCardState extends State<DiceCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AudioPlayer _audioPlayer;

  final Random _random = Random();
  bool _isRolling = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Initialize audio player
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/dice_sound.mp3');
    } catch (e) {
      debugPrint('Audio preload error: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // ============================================================
  // ROLL DICE -> SOUND + ANIMATION -> NAVIGATION
  // ============================================================

  Future<void> _rollAndNavigate() async {
    if (_isRolling) return;

    setState(() {
      _isRolling = true;
    });

    _animationController.reset();

    // Play rolling audio asset cleanly
    _playRollSound();

    // Start dice animation
    await _animationController.forward();

    if (!mounted) return;

    setState(() {
      _isRolling = false;
    });

    // Existing navigation
    Get.toNamed(AppRoutes.rollDice);
  }

  // ============================================================
  // ROLLING SOUND EXECUTOR
  // ============================================================

  Future<void> _playRollSound() async {
    try {
      // Reset sound position to beginning if re-triggered quickly
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        20,
        18,
        18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF21123D),
            Color(0xFF120D25),
            Color(0xFF0D0A1C),
          ],
        ),
        border: Border.all(
          color: AppColors.purple.withOpacity(0.28),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withOpacity(0.16),
            blurRadius: 30,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          // ======================================================
          // HEADER
          // ======================================================

          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: AppColors.purple.withOpacity(0.14),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.violet,
                  size: 18,
                ),
              ),

              const SizedBox(width: 10),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR NEXT ROLL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.3,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Choose players and let the dice decide',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ======================================================
          // CENTER DICE
          // ======================================================

          GestureDetector(
            onTap: _rollAndNavigate,
            child: SizedBox(
              width: 200,
              height: 190,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final progress = _animationController.value;

                  // No transformation at rest.
                  if (progress == 0.0 || progress == 1.0) {
                    return Center(
                      child: child,
                    );
                  }

                  // ------------------------------------------------
                  // SMOOTH ROLL CURVE
                  // ------------------------------------------------

                  final rollCurve =
                      Curves.easeInOutCubic.transform(progress);

                  final bounceCurve =
                      sin(progress * pi);

                  // ------------------------------------------------
                  // LIFT & MOVEMENT
                  // ------------------------------------------------

                  final lift = bounceCurve * 22;
                  final moveX = sin(progress * pi * 5) * 11;
                  final moveY = sin(progress * pi * 8) * 5;
                  final scale = 1.0 + bounceCurve * 0.07;

                  // ------------------------------------------------
                  // 3D-LIKE ROTATION
                  // ------------------------------------------------

                  final rotationX = sin(rollCurve * pi * 2.0) * 0.55;
                  final rotationY = rollCurve * pi * 2.0;
                  final rotationZ = sin(rollCurve * pi * 3.0) * 0.38;

                  return Center(
                    child: Transform.translate(
                      offset: Offset(
                        moveX,
                        -lift + moveY,
                      ),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(
                            3,
                            2,
                            0.0012,
                          )
                          ..rotateX(rotationX)
                          ..rotateY(rotationY)
                          ..rotateZ(rotationZ)
                          ..scale(scale),
                        child: child,
                      ),
                    ),
                  );
                },

                // ==================================================
                // ORIGINAL DICE
                // ==================================================

                child: _buildVisualDice(),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ======================================================
          // TITLE
          // ======================================================

          const Text(
            'Ready to roll?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Start a new dice game',
            style: TextStyle(
              color: Colors.white.withOpacity(0.42),
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 17),

          // ======================================================
          // ROLL BUTTON
          // ======================================================

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: _isRolling ? null : _rollAndNavigate,
              icon: const Icon(
                Icons.casino_rounded,
                color: Colors.white,
              ),
              label: const Text(
                'ROLL DICE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                disabledBackgroundColor:
                    AppColors.purple.withOpacity(0.65),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORIGINAL CENTER DICE
  // ============================================================

  Widget _buildVisualDice() {
    return Container(
      width: 155,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFE8DFFF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withOpacity(0.45),
            blurRadius: 35,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: AppColors.blue.withOpacity(0.15),
            blurRadius: 50,
          ),
        ],
      ),
      child: Stack(
        children: [
          _pip(32, 32),
          _pip(32, 104),
          _pip(104, 32),
          _pip(104, 104),
          _pip(68, 68),
        ],
      ),
    );
  }

  // ============================================================
  // PIP
  // ============================================================

  Widget _pip(
    double left,
    double top,
  ) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: 18,
        height: 18,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              AppColors.purple,
              AppColors.blue,
            ],
          ),
        ),
      ),
    );
  }
}