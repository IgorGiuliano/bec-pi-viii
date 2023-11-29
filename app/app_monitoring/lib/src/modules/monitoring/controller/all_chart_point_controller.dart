import 'dart:math';

import 'package:app_monitoring/src/modules/monitoring/model/chart_point_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../model/chart_point_list.dart';
import '../services/all_chart_point_json_placeholder_service.dart';

class AllChartPointController extends ChangeNotifier {
  final AllCharPointPlaceholderService _allCharPointPlaceholderService;

  AllChartPointController(this._allCharPointPlaceholderService);
  AllChartPointListModel? chartPoint;

  List<FlSpot> spots2 = [FlSpot(0, 0)];
  List<FlSpot> spots3 = [FlSpot(0, 0)];

  Future<void> allChartPoint() async {
    chartPoint = await _allCharPointPlaceholderService.getChartPoint();
    notifyListeners();
  }

  double spotFailed(int index) {
    if (chartPoint?.chartPointList[index].color != 'APROVADO') {
      return chartPoint?.chartPointList[index].count.toDouble() ?? 0.0;
    }
    return 0.0;
  }

  double spotAproved(int index) {
    if (chartPoint?.chartPointList[index].color != 'REPROVADO') {
      return chartPoint?.chartPointList[index].count.toDouble() ?? 0.0;
    }
    return 0.0;
  }

  double getMaxY() {
    double maxY = 0;
    for (var spot in spots2) {
      maxY = max(maxY, spot.y);
    }
    for (var spot in spots3) {
      maxY = max(maxY, spot.y);
    }
    return maxY;
  }

  double getMinY() {
    double minY = 0;
    for (var spot in spots2) {
      minY = min(minY, spot.y);
    }
    for (var spot in spots3) {
      minY = min(minY, spot.y);
    }
    return minY;
  }
}
