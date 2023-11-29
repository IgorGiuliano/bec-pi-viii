import '../model/chart_point_list.dart';
import 'all_chart_point_abstract.dart';

const url = 'https://api-robotinic.onrender.com/robotic-arm/get-last-twenty';

class AllCharPointPlaceholderService {
  final AllCharPointAbstract client;
  AllCharPointPlaceholderService(this.client);

  Future<AllChartPointListModel> getChartPoint() async {
    final response = await client.get(url);

    return AllChartPointListModel.fromJson(response);
  }
}
