import 'package:app_monitoring/src/modules/monitoring/model/monitoring_model.dart';

import 'monitoring_http_client_abstract.dart';

const url = 'https://jsonplaceholder.typicode.com/todos/1';

class MonitoringJsonPlaceholderService {
  final MonitoringHttpClientAbstract client;

  MonitoringJsonPlaceholderService(this.client);

  Future<MonitoringModel> getMonitoring() async {
    final response = await client.get(url);

    return MonitoringModel.fromJson(response);
  }
}
