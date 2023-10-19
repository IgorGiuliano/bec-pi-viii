import 'package:app_monitoring/src/modules/monitoring/model/monitoring_model.dart';
import 'package:app_monitoring/src/modules/monitoring/services/monitoring_json_placeholder_service.dart';
import 'package:flutter/cupertino.dart';

class MonitoringController extends ChangeNotifier {
  final MonitoringJsonPlaceholderService _service;
  MonitoringController(this._service);

  var monitoring = <MonitoringModel>[];

  Future<void> fetchAllMonitoring() async {
    monitoring = await _service.getMonitoring();
    notifyListeners();
  }
}
