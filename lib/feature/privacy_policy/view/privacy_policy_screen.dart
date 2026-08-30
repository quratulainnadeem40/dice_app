import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05071D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF070921),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 19,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.shield_rounded,
              color: Color(0xFF8B2CFF),
              size: 22,
            ),
            SizedBox(width: 10),
            Text(
              'Privacy Policy',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFF202449),
            height: 1,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ====================================================
                // HEADER CARD
                // ====================================================
                _buildHeaderCard(),

                const SizedBox(height: 20),

                // ====================================================
                // SECTIONS
                // ====================================================
                _buildSection(
                  icon: Icons.info_outline_rounded,
                  title: '1. Overview & Commitment',
                  content:
                      'Innovexa Technologies built the Dice Roller app as a free, offline-first utility application. We are deeply committed to respecting and protecting your privacy. This policy outlines our complete data practices.',
                ),

                _buildSection(
                  icon: Icons.no_accounts_rounded,
                  title: '2. Zero Personal Data Collection',
                  content:
                      '• No Account Required: You do not need to register, log in, or provide any personal details (name, email, phone number, or location).\n'
                      '• No Tracking: We do not track user behavior, device identifiers, or IP addresses.\n'
                      '• 100% Offline: The app functions entirely locally without transmitting data over the internet.',
                ),

                _buildSection(
                  icon: Icons.vibration_rounded,
                  title: '3. System Permissions',
                  content:
                      '• Vibration (android.permission.VIBRATE): Used solely to provide tactile haptic vibration when rolling dice for an authentic physical dice feel.\n'
                      '• No Sensitive Permissions: The app does not request access to contacts, files, photos, camera, or microphone.',
                ),

                _buildSection(
                  icon: Icons.sd_storage_rounded,
                  title: '4. Local Data Storage & Control',
                  content:
                      '• Preferences: Non-personal user preferences (selected dice theme, custom colors, animation speed, sound volume, vibration intensity) are saved locally on your device.\n'
                      '• History: Game roll history records are stored purely inside your device\'s local application sandbox.\n'
                      '• User Control: You have complete control and can erase all roll history records at any time using the "Clear History" button inside the app.',
                ),

                _buildSection(
                  icon: Icons.block_rounded,
                  title: '5. Third-Party Services & Ads',
                  content:
                      'Dice Roller contains no third-party advertising SDKs, behavioral trackers, or external monetization services. Your usage is completely private.',
                ),

                _buildSection(
                  icon: Icons.child_care_rounded,
                  title: '6. Children\'s Privacy (COPPA)',
                  content:
                      'Our application is family-friendly and suitable for all age groups (3+). Because we do not collect any personal data whatsoever, we strictly adhere to COPPA (Children\'s Online Privacy Protection Act) and global privacy regulations (GDPR, CCPA).',
                ),

                _buildSection(
                  icon: Icons.security_rounded,
                  title: '7. Data Security',
                  content:
                      'Since no user data is ever transmitted across external networks or stored on cloud servers, your information is completely safe from unauthorized access, interception, or server breaches.',
                ),

                // ====================================================
                // CONTACT US CARD
                // ====================================================
                _buildContactCard(),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF20133E),
            Color(0xFF130F2B),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF8B2CFF).withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B2CFF).withValues(alpha: 0.12),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B2CFF).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF8B2CFF).withValues(alpha: 0.5),
                  ),
                ),
                child: const Text(
                  'OFFICIAL POLICY',
                  style: TextStyle(
                    color: Color(0xFFC5BAFF),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'Updated Aug 2026',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Dice Roller Privacy Policy',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Innovexa Technologies • 100% Offline & Private',
            style: TextStyle(
              color: Color(0xFFB4B9D2),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0F2B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.07),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: const Color(0xFF8B2CFF),
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: const TextStyle(
              color: Color(0xFFB8BCD4),
              fontSize: 13,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF161338),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF8B2CFF).withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              Icon(
                Icons.support_agent_rounded,
                color: Color(0xFF8B2CFF),
                size: 22,
              ),
              SizedBox(width: 10),
              Text(
                'Contact & Support',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'For any questions, feedback, or inquiries regarding this Privacy Policy, please contact our support team at:',
            style: TextStyle(
              color: Color(0xFFB4B9D2),
              fontSize: 13,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Innovexa Technologies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'innovexa.technologies01@gmail.com',
            style: TextStyle(
              color: Color(0xFFB69AFF),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
