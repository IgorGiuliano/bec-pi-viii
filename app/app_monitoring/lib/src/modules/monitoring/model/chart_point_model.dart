import 'robotic_arm_model.dart';

class ChartPointModel {
  int count;
  String color;
  RoboticArmModel roboticArm;
  int collectTimestamp;

  ChartPointModel(
      {required this.count,
      required this.color,
      required this.roboticArm,
      required this.collectTimestamp});

  factory ChartPointModel.fromJson(Map<String, dynamic> json) {
    return ChartPointModel(
      count: json['count'],
      color: json['color'],
      roboticArm: RoboticArmModel.fromjson(json['robotic_arm']),
      collectTimestamp: json['collect_timestamp'],
    );
  }
}
