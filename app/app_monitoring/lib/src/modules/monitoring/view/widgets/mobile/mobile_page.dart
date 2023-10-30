import 'package:flutter/material.dart';

import '../defaul/charts_widget.dart';
import '../defaul/statistics_widget.dart';

class MobilePage extends StatelessWidget {
  const MobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4FC3F7),
            Color(0xFF29B6F6),
            Color(0xFF03A9F4),
            Color(0xFF039BE5),
            Color(0xFF0288D1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Column(
        children: [
          StatisticsWidget(),
          ChartsWidget(),
        ],
      ),
    );
  }
}
