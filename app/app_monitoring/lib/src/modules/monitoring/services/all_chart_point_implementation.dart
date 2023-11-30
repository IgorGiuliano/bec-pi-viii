import 'package:dio/dio.dart';

import 'all_chart_point_abstract.dart';

class AllChartPointImplementation implements AllCharPointAbstract {
  final dio = Dio();
  @override
  Future get(String url) async {
    final response = await dio.get(url);
    return response.data;
  }
}
