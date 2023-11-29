import 'package:app_monitoring/src/modules/monitoring/view/widgets/defaul/charts_widget.dart';
import 'package:app_monitoring/src/modules/monitoring/view/widgets/defaul/statistics_widget.dart';
import 'package:app_monitoring/src/modules/monitoring/view/widgets/defaul/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebPage extends StatelessWidget {
  const WebPage({
    super.key,
  });

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
      child: Column(
        children: [
          Row(
            children: [
              const DrawerWidget(),
              Expanded(
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatisticsWidget(),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 40, right: 38.w),
                        //   child: ElevatedButton(
                        //       onPressed: () {},
                        //       style: ButtonStyle(
                        //           backgroundColor:
                        //               MaterialStateColor.resolveWith(
                        //             (states) => Colors.amberAccent,
                        //           ),
                        //           alignment: Alignment.centerLeft),
                        //       child: const Text(
                        //         'Resetar',
                        //         style: TextStyle(color: Colors.black),
                        //       )),
                        // ),
                      ],
                    ),
                    SizedBox(height: 140.w, child: const ChartsWidget()),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
