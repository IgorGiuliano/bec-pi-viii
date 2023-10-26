import 'package:app_monitoring/src/modules/monitoring/controller/monitoring_controller.dart';
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

  @override
  void initState() {
    super.initState();
    controller.fetchAllMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4FC3F7),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0xFF4FC3F7),
      ),
      endDrawer: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200.w,
            height: 200.w,
            child: Image.asset('assets/images/png/logo.png'),
          ),
          const Text(
            '\nCentro universitário Senac\n\nPI8 - App de monitoramento\n\nRubens Prado\nIgor Giuliano\nGuilherme Chiquito\nPaulo Vaamond\nHenrique\nMateus Porto\nLucas Sampaio\n\n1.0.0 ',
            textAlign: TextAlign.center,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.replay_outlined,
          color: Colors.black,
        ),
      ),
      body: AnimatedBuilder(
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
                                  fontSize: 20.w, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'REPROVADO',
                              style: TextStyle(
                                  fontSize: 20.w, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'TOTAL',
                              style: TextStyle(
                                  fontSize: 20.w, fontWeight: FontWeight.bold),
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
            ],
          );
        },
      ),
    );
  }
}
