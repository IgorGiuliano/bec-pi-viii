import 'dart:math';

import 'package:app_monitoring/src/modules/monitoring/model/monitoring_model.dart';
import 'package:app_monitoring/src/modules/monitoring/services/monitoring_json_placeholder_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class MonitoringController extends ChangeNotifier {
  final MonitoringJsonPlaceholderService _service;
  MonitoringController(this._service);

  MonitoringModel? monitoring;

  List<FlSpot> spots2 = [];

  List<FlSpot> spots3 = [];

  Future<void> fetchAllMonitoring() async {
    monitoring = await _service.getMonitoring();
    notifyListeners();
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
