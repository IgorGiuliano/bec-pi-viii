import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/all_chart_point_controller.dart';

class ChartsWidget extends StatefulWidget {
  const ChartsWidget({
    super.key,
  });

  @override
  State<ChartsWidget> createState() => _ChartsWidgetState();
}

class _ChartsWidgetState extends State<ChartsWidget> {
  final controller = Modular.get<AllChartPointController>();
  final spotAproved = Modular.get<AllChartPointController>().spots2;
  final spotFailed = Modular.get<AllChartPointController>().spots3;

  late Timer timer;
  int timeInSeconds = 0;
  @override
  void initState() {
    super.initState();
    controller.allChartPoint();
    int index = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeInSeconds++;
        spotAproved.add(
            FlSpot(timeInSeconds.toDouble(), controller.spotAproved(index)));
        spotFailed.add(
            FlSpot(timeInSeconds.toDouble(), controller.spotFailed(index)));

        if (spotAproved.length > 8) {
          spotAproved.removeAt(0);
          spotFailed.removeAt(0);
        }
        index++;
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
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.chartPoint == null) {
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
                          return Text(value.toString());
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toString());
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
                  minY: controller.getMinY(),
                  maxY: controller.getMaxY(),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spotFailed,
                      color: Colors.red,
                      dotData: const FlDotData(show: true),
                    ),
                    LineChartBarData(
                      spots: spotAproved,
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
