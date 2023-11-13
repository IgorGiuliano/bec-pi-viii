import 'package:app_monitoring/src/core/core_module.dart';
import 'package:app_monitoring/src/modules/auth/auth_module.dart';
import 'package:app_monitoring/src/modules/monitoring/controller/monitoring_controller.dart';
import 'package:app_monitoring/src/modules/monitoring/services/monitoring_dio_client_implementation.dart';
import 'package:app_monitoring/src/modules/monitoring/services/monitoring_http_client_abstract.dart';
import 'package:app_monitoring/src/modules/monitoring/services/monitoring_json_placeholder_service.dart';
import 'package:app_monitoring/src/modules/monitoring/view/page/monitoring_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'routes_monitoring.dart';

class MonitoringModule extends Module {
  @override
  List<Module> get imports => [
        AuthModule(),
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton(MonitoringController.new);
    i.addSingleton(MonitoringJsonPlaceholderService.new);
    i.addSingleton<MonitoringHttpClientAbstract>(
        MonitoringDioClientImplementation.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(RoutesMonitoring.DEFAULT, child: (_) => const MonitoringPage());
  }
}
