class RoboticArmModel {
  String idRoboticArm;
  String name;
  RoboticArmModel({
    required this.idRoboticArm,
    required this.name,
  });

  factory RoboticArmModel.fromjson(Map<String, dynamic> json) {
    return RoboticArmModel(
      idRoboticArm: json['id_roboticArm'],
      name: json['name'],
    );
  }
}
