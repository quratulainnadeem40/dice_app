// class HomeModel {
//   final String userName;
//   final int totalRolls;
//   final int lastRollResult;
//   final String recentAchievement;

//   HomeModel({
//     required this.userName,
//     required this.totalRolls,
//     required this.lastRollResult,
//     required this.recentAchievement,
//   });
// }
class HomeModel {
  final int totalRolls;
  final int lastRoll;
  final String userName;

  HomeModel({
    required this.totalRolls,
    required this.lastRoll,
    required this.userName,
  });
}