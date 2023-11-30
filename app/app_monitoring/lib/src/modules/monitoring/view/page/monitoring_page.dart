import 'package:flutter/material.dart';

import '../widgets/defaul/drawer_widget.dart';
import '../widgets/defaul/layuot_builder_widget.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;
        return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: const Color(0xFF4FC3F7),
            ),
            endDrawer: isMobile ? const DrawerWidget() : null,
            // floatingActionButton:
            //     isMobile ? const MobileFloatingActionButtonWidget() : null,
            body: const LayoutBuilderWidget());
      },
    );
  }
}
