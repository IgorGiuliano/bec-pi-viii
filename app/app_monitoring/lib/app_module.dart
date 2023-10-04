import 'package:flutter_modular/flutter_modular.dart';

import 'routes.dart';
import 'splash_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];
  @override
  List<ModularRoute> routes = [
    ChildRoute(Routes.DEFAULT, child: (_, args) => const SplashPage()),
  ];
}
