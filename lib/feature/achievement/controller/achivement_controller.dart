import 'package:get/get.dart';
import '../model/achievement_model.dart';

class AchievementController extends GetxController {
  final RxList<AchievementModel> achievements = <AchievementModel>[
    AchievementModel(
      id: '1',
      title: 'First Roll',
      description: 'Roll dice for the first time',
      currentProgress: 1,
      totalProgress: 1,
      isCompleted: true,
    ),
    AchievementModel(
      id: '2',
      title: 'Rolling Star',
      description: 'Roll 100 times',
      currentProgress: 75,
      totalProgress: 100,
      isCompleted: false,
    ),
    AchievementModel(
      id: '3',
      title: 'Lucky Roller',
      description: 'Get a total of 100',
      currentProgress: 100,
      totalProgress: 100,
      isCompleted: true,
    ),
    AchievementModel(
      id: '4',
      title: 'Dice Master',
      description: 'Roll 6 dice together',
      currentProgress: 2,
      totalProgress: 10,
      isCompleted: false,
    ),
    AchievementModel(
      id: '5',
      title: 'Streak King',
      description: 'Roll 5 times in a row',
      currentProgress: 5,
      totalProgress: 5,
      isCompleted: true,
    ),
  ].obs;
}