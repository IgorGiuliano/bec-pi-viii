import 'package:app_monitoring/src/modules/monitoring/controller/monitoring_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  final controller = Modular.get<MonitoringController>();

  @override
  void initState() {
    super.initState();
    controller.fetchAllMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return ListView.builder(
            itemCount: controller.monitoring.length,
            itemBuilder: (context, index) {
              final monitorin = controller.monitoring[index];
              return ListTile(
                title: Text(monitorin.title),
              );
            },
          );
        },
      ),
    );
  }
}
