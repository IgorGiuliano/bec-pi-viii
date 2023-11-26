import 'all_check_model.dart';
import 'check_list_object_model.dart';

class DataCheckListModel {
  AllCheckModel firstElement;
  List<CheckListObjectModel> secondElement;

  DataCheckListModel({required this.firstElement, required this.secondElement});

  factory DataCheckListModel.fromJson(List<dynamic> json) {
    return DataCheckListModel(
      firstElement: AllCheckModel.fromJson(json[0]['_sum']),
      secondElement: json[1]
          .map<CheckListObjectModel>(
              (item) => CheckListObjectModel.fromJson(item))
          .toList(),
    );
  }
}
