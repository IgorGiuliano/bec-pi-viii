import 'dart:async';
import 'dart:math';

import 'package:app_monitoring/src/modules/monitoring/controller/monitoring_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartsWidget extends StatefulWidget {
  const ChartsWidget({
    super.key,
  });

  @override
  State<ChartsWidget> createState() => _ChartsWidgetState();
}

class _ChartsWidgetState extends State<ChartsWidget> {
  final controller = Modular.get<MonitoringController>();
  final spots2 = Modular.get<MonitoringController>().spots2;
  final spots3 = Modular.get<MonitoringController>().spots3;
  final getMinY = Modular.get<MonitoringController>().getMinY();

  late Timer timer;
  int timeInSeconds = 0;
  @override
  void initState() {
    super.initState();
    controller.fetchAllMonitoring();
    //controller.allChartPoint();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeInSeconds += 1;
        spots2.add(FlSpot(timeInSeconds.toDouble(), (timeInSeconds + 2) % 6));
        spots3.add(FlSpot(timeInSeconds.toDouble(), (timeInSeconds + 4) % 6));

        if (spots2.length > 8) {
          spots2.removeAt(0);
          spots3.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(controller.chartPoint?.color ?? '');
    // print(controller.chartPoint?.count ?? '');
    // print(controller.chartPoint?.collectTimestamp.isUtc ?? '');
    // print(controller.chartPoint?.roboticArm.idRoboticArm ?? '');
    // print(controller.chartPoint?.roboticArm.name ?? '');
    // print(controller.monitoring?.firstElement.count ?? '');
    // print(controller.monitoring?.secondElement[0].color ?? '');
    // print(controller.monitoring?.secondElement[0].sum ?? 0);
    // print(controller.monitoring?.secondElement[1].color ?? '');
    // print(controller.monitoring?.secondElement[1].sum ?? 0);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.monitoring == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding:
              EdgeInsets.only(top: 28, right: 28.w, left: 28.w, bottom: 28.w),
          child: Container(
            height: 300.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      left: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                    ),
                  ),
                  minX: max(0, timeInSeconds - 7).toDouble(),
                  maxX: timeInSeconds.toDouble(),
                  minY: getMinY,
                  maxY: controller.monitoring?.firstElement.count,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots2,
                      color: Colors.red,
                      dotData: const FlDotData(show: true),
                    ),
                    LineChartBarData(
                      spots: spots3,
                      color: Colors.green,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
