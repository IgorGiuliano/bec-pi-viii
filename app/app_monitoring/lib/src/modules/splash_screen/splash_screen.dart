import 'package:app_monitoring/src/modules/monitoring/routes_monitoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../routes_moludes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // Widget build(BuildContext context) {
  //   return const Placeholder();
  // }
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .then((_) => Modular.to.pushReplacementNamed('${RoutesModules.MONITORING_MODULE}${RoutesMonitoring.DEFAULT}'));
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child:CircularProgressIndicator()),
    );
  }
}
