import 'package:app_monitoring/src/modules/monitoring/model/point.dart';

import '../model/data_check_list_model.dart';
import 'monitoring_http_client_abstract.dart';

// const url = 'https://api-robotinic.onrender.com/robotic-arm/count-day-records';

class MonitoringJsonPlaceholderService {
  final MonitoringHttpClientAbstract client;

  MonitoringJsonPlaceholderService(this.client);

  Future<DataCheckListModel> getMonitoring(String url1) async {
    final response = await client.get(url1);

    return DataCheckListModel.fromJson(response);
  }

  Future<ChartPoint> getChart(String url2) async {
    final response = await client.get(url2);

    return ChartPoint.fromJson(response);
  }
}
