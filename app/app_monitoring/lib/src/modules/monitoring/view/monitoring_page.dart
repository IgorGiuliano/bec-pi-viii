import 'dart:async';
import 'dart:math';

import 'package:app_monitoring/src/modules/monitoring/controller/monitoring_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage> {
  final controller = Modular.get<MonitoringController>();

  List<FlSpot> spots2 = [
    FlSpot(0, 4),
  ];

  List<FlSpot> spots3 = [
    FlSpot(0, 7),
  ];

  late Timer timer;
  int timeInSeconds = 0;
  @override
  void initState() {
    super.initState();
    controller.fetchAllMonitoring();
    // }

    // @override
    // void initState() {
    //   super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
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

  double getMaxY() {
    double maxY = 6;
    for (var spot in spots2) {
      maxY = max(maxY, spot.y);
    }
    for (var spot in spots3) {
      maxY = max(maxY, spot.y);
    }
    return maxY;
  }

  void resetGraph() {
    setState(() {
      timeInSeconds = 0;
      spots2.clear();
      spots3.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF4FC3F7),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0xFF4FC3F7),
      ),
      endDrawer: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 38.w, bottom: 38.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.w,
                height: 200.w,
                child: Image.asset('assets/images/png/logo.png'),
              ),
              const Text(
                '\nCentro Universitário Senac\n\nPI8 - App de monitoramento\n\nGuilherme Chiquito\nHenrique Jorge\nIgor Giuliano\nLucas Sampaio\nMateus Porto\nPaulo Vaamond\nRubens Prado\n\n1.0.0 ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => reassemble(),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.replay_outlined,
          color: Colors.black,
        ),
      ),
      body: Container(
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
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            // final monitorin = controller.monitoring;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40.w, right: 28.w, left: 28.w),
                  child: Container(
                    width: 307.w,
                    height: 118.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.w),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.only(top: 24.w, right: 24.w),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(monitorin?.title ?? 'null'),
                              Text(
                                'APROVADO',
                                style: TextStyle(
                                    fontSize: 20.w,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'REPROVADO',
                                style: TextStyle(
                                    fontSize: 20.w,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'TOTAL',
                                style: TextStyle(
                                    fontSize: 20.w,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 34.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '150',
                                  style: TextStyle(
                                      fontSize: 20.w,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                Text(
                                  '20',
                                  style: TextStyle(
                                      fontSize: 20.w,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  '170',
                                  style: TextStyle(
                                      fontSize: 20.w,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 28.w, right: 28.w, left: 28.w),
                  child: Container(
                    height: 300.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.w),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: FlTitlesData(
                            show: true,
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30.w,
                                getTitlesWidget: (value, meta) {
                                  return Text(value.toInt().toString());
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30.w,
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
                          minY: 0,
                          maxY: getMaxY(),
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
