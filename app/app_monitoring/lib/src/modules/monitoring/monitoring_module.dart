import 'package:app_monitoring/src/core/core_module.dart';
import 'package:app_monitoring/src/modules/auth/auth_module.dart';
import 'package:app_monitoring/src/modules/monitoring/view/monitoring_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../routes_moludes.dart';
import 'routes_monitoring.dart';

class MonitoringModule extends Module {
  @override
  List<Module> get imports => [
        AuthModule(),
        CoreModule(),
      ];

  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(RoutesMonitoring.DEFAULT, child: (_) => const MonitoringPage());
  }
}
