import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiceCard extends StatelessWidget {
  const DiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
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

          // Visual Dice
          _buildVisualDice(),

          const SizedBox(height: 20),

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

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.rollDice);
              },
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

  Widget _pip(double left, double top) {
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