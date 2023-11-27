import 'package:app_monitoring/src/modules/monitoring/monitoring_module.dart';
import 'package:app_monitoring/src/modules/splash_screen/splash_screen.dart';
import 'package:app_monitoring/src/routes_moludes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [MonitoringModule()];
  @override
  void routes(RouteManager r) {
    r.child(RoutesModules.DEFAULT, child: (_) => const SplashScreen());
    r.module(RoutesModules.MONITORING_MODULE, module: MonitoringModule());
  }
}
