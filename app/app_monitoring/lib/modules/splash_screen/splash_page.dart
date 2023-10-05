import 'package:app_monitoring/src/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .then((_) => Modular.to.navigate(Routes.HOME));
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child:CircularProgressIndicator()),
    );
  }
}
