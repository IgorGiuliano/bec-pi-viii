import 'package:app_monitoring/src/modules/monitoring/services/monitoring_json_placeholder_service.dart';
import 'package:flutter/cupertino.dart';

import '../model/data_check_list_model.dart';

class MonitoringController extends ChangeNotifier {
  final MonitoringJsonPlaceholderService _monitoringJsonPlaceholderService;
  MonitoringController(this._monitoringJsonPlaceholderService);

  DataCheckListModel? monitoring;

  Future<void> fetchAllMonitoring() async {
    monitoring = await _monitoringJsonPlaceholderService.getMonitoring();
    notifyListeners();
  }
}
