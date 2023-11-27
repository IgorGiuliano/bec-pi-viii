import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import 'package:app_monitoring/src/modules/monitoring/services/monitoring_json_placeholder_service.dart';

import '../model/data_check_list_model.dart';
import '../model/point.dart';

class MonitoringController extends ChangeNotifier {
  final MonitoringJsonPlaceholderService _service;
  MonitoringController(
    this._service,
  );

  List<FlSpot> spots2 = [FlSpot(0, 4)];

  List<FlSpot> spots3 = [FlSpot(0, 2)];

  DataCheckListModel? monitoring;
  ChartPoint? chartPoint;

  Future<void> fetchAllMonitoring() async {
    monitoring = await _service.getMonitoring(
        'https://api-robotinic.onrender.com/robotic-arm/count-day-records');
    notifyListeners();
  }

  Future<void> allChartPoint() async {
    chartPoint = await _service.getChart(
        'https://api-robotinic.onrender.com/robotic-arm/get-last-twenty');
    notifyListeners();
  }

  Future<List<FlSpot>> createSpotsFromChartPoint() async {
    double xValue =
        chartPoint!.collectTimestamp.millisecondsSinceEpoch.toDouble();
    double yValue = chartPoint!.count;

    if (chartPoint?.color == 'red' || chartPoint?.color == 'green') {
      return [FlSpot(xValue, yValue)];
    } else {
      return [const FlSpot(0, 0)];
    }
  }

  double getMaxY() {
    double maxY = 6;
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
