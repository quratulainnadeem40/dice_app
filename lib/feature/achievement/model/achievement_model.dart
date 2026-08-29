class AchievementModel {
  final String title;
  final String description;
  final int currentProgress;
  final int totalProgress;
  final bool isCompleted;

  AchievementModel({
    required this.title,
    required this.description,
    required this.currentProgress,
    required this.totalProgress,
    required this.isCompleted,
  });
}