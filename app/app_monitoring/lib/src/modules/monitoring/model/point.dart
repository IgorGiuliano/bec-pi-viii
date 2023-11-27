class ChartPoint {
  double count;
  String color;
  RoboticArm roboticArm;
  DateTime collectTimestamp;

  ChartPoint(
      {required this.count,
      required this.color,
      required this.roboticArm,
      required this.collectTimestamp});

  factory ChartPoint.fromJson(Map<String, dynamic> json) {
    return ChartPoint(
      count: json['count'],
      color: json['color'],
      roboticArm: RoboticArm.fromJson(json['robotic_arm']),
      collectTimestamp: json['collect_timestamp'],
    );
  }
}

class RoboticArm {
  String idRoboticArm;
  String name;

  RoboticArm({
    required this.idRoboticArm,
    required this.name,
  });

  factory RoboticArm.fromJson(Map<String, dynamic> json) {
    return RoboticArm(
      idRoboticArm: json['id_roboticArm'],
      name: json['name'],
    );
  }
}