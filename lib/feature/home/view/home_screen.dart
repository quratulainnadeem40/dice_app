import 'package:dice_app/feature/home/widgets/quick_action.dart';
import 'package:flutter/material.dart';
import '../widgets/dice_card.dart';

import '../widgets/home_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080617),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Header
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: const Color(0xFF171229),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF302346),
                                ),
                              ),
                              child: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),

                            const SizedBox(width: 12),

                            const Text(
                              'DICE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: const Color(0xFF171229),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF302346),
                            ),
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: Color(0xFFFFC857),
                            size: 22,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Welcome Text
                    const Center(
                      child: Text(
                        'Welcome back! 👋',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Center(
                      child: Text(
                        'Ready to roll?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Dice Card
                    DiceCard(),

                    const SizedBox(height: 18),

                    // Quick Actions
                    Row(
                      children: [
                        QuickActionCard(
                          icon: Icons.people_alt_outlined,
                          title: 'Two Players',
                        ),
                        QuickActionCard(
                          icon: Icons.emoji_events_outlined,
                          title: 'High Score',
                        ),
                        QuickActionCard(
                          icon: Icons.bar_chart_rounded,
                          title: 'Statistics',
                        ),
                        QuickActionCard(
                          icon: Icons.settings_outlined,
                          title: 'Settings',
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            HomeBottomNav(),
          ],
        ),
      ),
    );
  }
}