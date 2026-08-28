import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:dice_app/feature/home/widgets/dice_card.dart';
import 'package:dice_app/feature/home/widgets/home_bottom_nav.dart';
import 'package:dice_app/feature/home/widgets/quick_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -100,
            child: _buildGlow(
              AppColors.purple.withOpacity(0.18),
              280,
            ),
          ),

          Positioned(
            top: 280,
            left: -150,
            child: _buildGlow(
              AppColors.blue.withOpacity(0.10),
              300,
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                20,
                16,
                20,
                120,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),

                  const SizedBox(height: 30),

                  _buildWelcome(),

                  const SizedBox(height: 24),

                   DiceCard(),

                  const SizedBox(height: 30),

                  _buildQuickActions(),

                  const SizedBox(height: 24),

                  _buildFeatureBanner(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNav(),
    );
  }

  Widget _buildGlow(Color color, double size) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 100,
              spreadRadius: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
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
                blurRadius: 22,
              ),
            ],
          ),
          child: const Icon(
            Icons.casino_rounded,
            color: Colors.white,
            size: 28,
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
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
            Text(
              'ROLL • PLAY • WIN',
              style: TextStyle(
                color: Colors.white.withOpacity(0.38),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),

        const Spacer(),

        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.055),
            border: Border.all(
              color: Colors.white.withOpacity(0.10),
            ),
          ),
          child: const Icon(
            Icons.person_outline_rounded,
            color: AppColors.lightText,
            size: 22,
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

        const SizedBox(height: 12),

        Row(
          children: [
            Container(
              width: 45,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.purple,
                    AppColors.blue,
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              width: 8,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.violet,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            QuickActionCard(
              icon: Icons.people_alt_rounded,
              title: 'Players',
              onTap: () {
                Get.toNamed(AppRoutes.rollDice);
              },
            ),
            QuickActionCard(
              icon: Icons.emoji_events_rounded,
              title: 'Scores',
              onTap: () {},
            ),
            QuickActionCard(
              icon: Icons.bar_chart_rounded,
              title: 'Stats',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            AppColors.purple.withOpacity(0.16),
            AppColors.blue.withOpacity(0.07),
          ],
        ),
        border: Border.all(
          color: AppColors.purple.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.purple.withOpacity(0.12),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.violet,
            ),
          ),

          const SizedBox(width: 13),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make every roll count',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Choose players and start your game.',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white38,
            size: 14,
          ),
        ],
      ),
    );
  }
}