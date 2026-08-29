class AppConstants {
  // App Name
  static const String appName = 'DICE ROLLER';
  static const String appVersion = '1.0.0';

  // Animation durations
  static const Duration diceRollDuration = Duration(milliseconds: 600);
  static const Duration cardAnimationDuration = Duration(milliseconds: 300);
  static const Duration screenTransitionDuration = Duration(milliseconds: 400);

  // Dice settings
  static const int defaultDiceCount = 1;
  static const int defaultDiceSides = 6;
  static const int minDiceCount = 1;
  static const int maxDiceCount = 10;
  static const int minDiceSides = 4;
  static const int maxDiceSides = 20;

  // Multiplayer
  static const int maxPlayers = 4;
  static const int minPlayers = 2;

  // Storage keys
  static const String diceCountKey = 'diceCount';
  static const String diceSidesKey = 'diceSides';
  static const String diceColorKey = 'diceColor';
  static const String soundEnabledKey = 'soundEnabled';
  static const String vibrationEnabledKey = 'vibrationEnabled';
  static const String animationSpeedKey = 'animationSpeed';
  static const String rollHistoryKey = 'rollHistory';
  static const String achievementsKey = 'achievements';

  // API delays
  static const Duration animationDelay = Duration(milliseconds: 100);
}