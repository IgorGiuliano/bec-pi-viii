import 'all_check_model.dart';

class CheckListObjectModel {
  AllCheckModel sum;
  String color;

  CheckListObjectModel({required this.sum, required this.color});

  factory CheckListObjectModel.fromJson(Map<String, dynamic> json) {
    return CheckListObjectModel(
      sum: AllCheckModel.fromJson(json['_sum']),
      color: json['color'],
    );
  }
}
