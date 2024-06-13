import 'package:cloud_firestore/cloud_firestore.dart';

class WaterIntake {
  String userId;
  int waterIntake;
  int dailyGoal;
  int fixedAmount;
  bool congratulationsShown;

  WaterIntake({
    required this.userId,
    required this.waterIntake,
    required this.dailyGoal,
    required this.fixedAmount,
    this.congratulationsShown = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'waterIntake': waterIntake,
      'dailyGoal': dailyGoal,
      'fixedAmount': fixedAmount,
      'congratulationsShown': congratulationsShown,
    };
  }

  factory WaterIntake.fromJson(Map<String, dynamic> json) {
    return WaterIntake(
      userId: json['userId'],
      waterIntake: json['waterIntake'],
      dailyGoal: json['dailyGoal'],
      fixedAmount: json['fixedAmount'],
      congratulationsShown: json['congratulationsShown'] ?? false,
    );
  }
}
