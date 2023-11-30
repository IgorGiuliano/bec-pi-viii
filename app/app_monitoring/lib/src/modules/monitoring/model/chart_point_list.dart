import 'chart_point_model.dart';

class AllChartPointListModel {
  List<ChartPointModel> chartPointList;

  AllChartPointListModel({required this.chartPointList});

  factory AllChartPointListModel.fromJson(List<dynamic> json) {
    List<ChartPointModel> chartPoints =
        json.map((item) => ChartPointModel.fromJson(item)).toList();
    return AllChartPointListModel(
      chartPointList: chartPoints,
    );
  }
}
