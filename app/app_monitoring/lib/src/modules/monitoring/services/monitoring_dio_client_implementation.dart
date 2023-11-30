import 'package:app_monitoring/src/modules/monitoring/services/monitoring_http_client_abstract.dart';
import 'package:dio/dio.dart';

class MonitoringDioClientImplementation
    implements MonitoringHttpClientAbstract {
  final dio = Dio();
  @override
  Future get(String url) async {
    final response = await dio.get(url);
    return response.data;
  }
}
