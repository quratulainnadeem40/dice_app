import 'package:dice_app/core/theme/custom_color.dart';
import 'package:dice_app/core/theme/custom_textstyle.dart';
import 'package:dice_app/feature/Roll_dice/view/roll_disc_screen.dart';
import 'package:dice_app/feature/home/widget/bottom_nav.dart';
import 'package:dice_app/feature/home/widget/dice_card.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildWelcome(),
              const SizedBox(height: 24),

              DiceCard(),

              const SizedBox(height: 24),

              // Context pass kiya hai navigation ke liye
              _buildInfoCard(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.purple,
                AppColors.violet,
                AppColors.blue,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.purple.withOpacity(0.35),
                blurRadius: 18,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Icon(
            Icons.casino_rounded,
            color: Colors.white,
            size: 27,
          ),
        ),

        const SizedBox(width: 13),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DICE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
            Text(
              'ROLL • PLAY • WIN',
              style: TextStyle(
                color: Colors.white.withOpacity(0.42),
                fontSize: 8,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),

        const Spacer(),

        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.06),
            border: Border.all(
              color: Colors.white.withOpacity(0.10),
            ),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: AppColors.lightText,
          ),
        ),
      ],
    );
  }

  Widget _buildWelcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good to see you 👋',
          style: AppTextStyles.homeGreeting,
        ),

        const SizedBox(height: 6),

        const Text(
          'Ready to roll?',
          style: AppTextStyles.homeHeading,
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.purple,
                    AppColors.blue,
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 8,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.violet,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RollDiceScreen(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white.withOpacity(0.035),
          border: Border.all(
            color: Colors.white.withOpacity(0.07),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: AppColors.purple.withOpacity(0.12),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.violet,
                size: 21,
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready for your next roll?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Choose your players and roll together.',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}