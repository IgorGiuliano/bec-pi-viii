import '../model/data_check_list_model.dart';
import 'monitoring_http_client_abstract.dart';

const url = 'https://api-robotinic.onrender.com/robotic-arm/count-day-records';

class MonitoringJsonPlaceholderService {
  final MonitoringHttpClientAbstract client;

  MonitoringJsonPlaceholderService(this.client);

  Future<DataCheckListModel> getMonitoring() async {
    final response = await client.get(url);

    return DataCheckListModel.fromJson(response);
  }
}


