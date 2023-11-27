import 'package:app_monitoring/src/modules/monitoring/view/widgets/web/web_page.dart';
import 'package:flutter/material.dart';

import '../mobile/mobile_page.dart';

class LayoutBuilderWidget extends StatefulWidget {
  const LayoutBuilderWidget({
    super.key,
  });

  @override
  State<LayoutBuilderWidget> createState() => _LayoutBuilderWidgetState();
}

class _LayoutBuilderWidgetState extends State<LayoutBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final bool isMobile = constrains.maxWidth < 600;
        return isMobile
            ? const MobilePage()
            : const SingleChildScrollView(child: WebPage());
      },
    );
  }
}
