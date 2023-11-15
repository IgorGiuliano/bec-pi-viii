import 'package:app_monitoring/src/modules/monitoring/view/widgets/web/web_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../controller/monitoring_controller.dart';
import '../mobile/mobile_page.dart';

class LayoutBuilderWidget extends StatefulWidget {
  const LayoutBuilderWidget({
    super.key,
  });

  @override
  State<LayoutBuilderWidget> createState() => _LayoutBuilderWidgetState();
}

class _LayoutBuilderWidgetState extends State<LayoutBuilderWidget> {
  final controller = Modular.get<MonitoringController>();

  @override
  void initState() {
    super.initState();
    controller.fetchAllMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final monitorin = controller.monitoring;
        return LayoutBuilder(
          builder: (context, constrains) {
            final bool isMobile = constrains.maxWidth < 600;
            return isMobile
                ? const MobilePage()
                : const SingleChildScrollView(child: WebPage());
          },
        );
      },
    );
  }
}
