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
        child: Center( 
          child: ConstrainedBox( 
            constraints: const BoxConstraints(maxWidth: 650), 
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
 
                  const DiceCard(), 
 
                  const SizedBox(height: 24), 
 
                  _buildInfoCard(context), 
                ], 
              ), 
            ), 
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
            boxShadow: [ 
              BoxShadow( 
                color: AppColors.purple.withValues(alpha: 0.35), 
                blurRadius: 18, 
                spreadRadius: 1, 
              ), 
            ], 
          ), 
          child: ClipRRect( 
            borderRadius: BorderRadius.circular(15), 
            child: Image.asset( 
              'assets/imagesfolder/logo_dice.png', 
              fit: BoxFit.cover, 
            ), 
          ), 
        ), 

        const SizedBox(width: 13), 

        Column( 
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [ 
            const Text( 
              'DICEROLL', 
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
                color: Colors.white.withValues(alpha: 0.42), 
                fontSize: 8, 
                fontWeight: FontWeight.w600, 
                letterSpacing: 1.2, 
              ), 
            ), 
          ], 
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
          color: Colors.white.withValues(alpha: 0.035), 
          border: Border.all( 
            color: Colors.white.withValues(alpha: 0.07), 
          ), 
        ), 
        child: Row( 
          children: [ 
            Container( 
              width: 42, 
              height: 42, 
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(13), 
                color: AppColors.purple.withValues(alpha: 0.12), 
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