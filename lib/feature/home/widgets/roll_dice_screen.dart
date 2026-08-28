import 'dart:math';

import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:flutter/material.dart';

class RollDiceScreen extends StatefulWidget {
  const RollDiceScreen({super.key});

  @override
  State<RollDiceScreen> createState() => _RollDiceScreenState();
}

class _RollDiceScreenState extends State<RollDiceScreen> {
  final Random _random = Random();

  int playerCount = 1;

  List<int> diceValues = [1];

  bool isRolling = false;

  Future<void> rollAllDice() async {
    if (isRolling) return;

    setState(() {
      isRolling = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 450),
    );

    setState(() {
      diceValues = List.generate(
        playerCount,
        (_) => _random.nextInt(6) + 1,
      );

      isRolling = false;
    });
  }

  void changePlayers(int value) {
    setState(() {
      playerCount = value;

      diceValues = List.generate(
        value,
        (_) => 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),

            const SizedBox(height: 8),

            _buildTitle(),

            const SizedBox(height: 18),

            _buildPlayerSelector(),

            const SizedBox(height: 18),

            Expanded(
              child: _buildDiceArea(),
            ),

            _buildRollButton(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.055),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          const Spacer(),

          const Text(
            'ROLL DICE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),

          const Spacer(),

          const SizedBox(width: 42),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          '$playerCount ${playerCount == 1 ? 'Player' : 'Players'}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          isRolling
              ? 'Rolling your dice...'
              : 'Tap ROLL to play',
          style: TextStyle(
            color: Colors.white.withOpacity(0.48),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.045),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.07),
        ),
      ),
      child: Row(
        children: List.generate(
          4,
          (index) {
            final value = index + 1;
            final selected = playerCount == value;

            return Expanded(
              child: GestureDetector(
                onTap: () => changePlayers(value),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    gradient: selected
                        ? const LinearGradient(
                            colors: [
                              AppColors.purple,
                              AppColors.violet,
                            ],
                          )
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      '$value',
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : Colors.white54,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDiceArea() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: playerCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: playerCount <= 2 ? playerCount : 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            return _buildPlayerDice(
              index,
              diceValues[index],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlayerDice(
    int playerIndex,
    int value,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'PLAYER ${playerIndex + 1}',
          style: TextStyle(
            color: Colors.white.withOpacity(0.45),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 10),

        AnimatedScale(
          scale: isRolling ? 0.88 : 1,
          duration: const Duration(milliseconds: 180),
          child: _buildDice(value),
        ),
      ],
    );
  }

  Widget _buildDice(int number) {
    return Container(
      width: playerCount == 1 ? 185 : 145,
      height: playerCount == 1 ? 185 : 145,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFE9E2FF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withOpacity(0.32),
            blurRadius: 32,
            spreadRadius: 2,
          ),
        ],
      ),
      child: _buildDicePips(number),
    );
  }

  Widget _buildDicePips(int number) {
    final positions = _pipPositions[number]!;

    return Padding(
      padding: const EdgeInsets.all(25),
      child: Stack(
        children: positions.map((position) {
          return Align(
            alignment: position,
            child: Container(
              width: playerCount == 1 ? 23 : 18,
              height: playerCount == 1 ? 23 : 18,
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
        }).toList(),
      ),
    );
  }

  Widget _buildRollButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: isRolling ? null : rollAllDice,
          icon: const Icon(
            Icons.casino_rounded,
            color: Colors.white,
          ),
          label: Text(
            isRolling ? 'ROLLING...' : 'ROLL ALL DICE',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple,
            disabledBackgroundColor:
                AppColors.purple.withOpacity(0.45),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
        ),
      ),
    );
  }

  static const Map<int, List<Alignment>> _pipPositions = {
    1: [
      Alignment.center,
    ],
    2: [
      Alignment.topLeft,
      Alignment.bottomRight,
    ],
    3: [
      Alignment.topLeft,
      Alignment.center,
      Alignment.bottomRight,
    ],
    4: [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomLeft,
      Alignment.bottomRight,
    ],
    5: [
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.center,
      Alignment.bottomLeft,
      Alignment.bottomRight,
    ],
    6: [
      Alignment.topLeft,
      Alignment.centerLeft,
      Alignment.bottomLeft,
      Alignment.topRight,
      Alignment.centerRight,
      Alignment.bottomRight,
    ],
  };
}