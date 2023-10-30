import 'package:app_monitoring/src/modules/monitoring/routes_monitoring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../routes_moludes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((_) => Modular.to
        .pushReplacementNamed(
            '${RoutesModules.MONITORING_MODULE}${RoutesMonitoring.DEFAULT}'));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4FC3F7),
              Color(0xFF29B6F6),
              Color(0xFF03A9F4),
              Color(0xFF039BE5),
              Color(0xFF0288D1),
              Color(0xFF0277BD),
              Color(0xFF01579B),
              Color(0xFF01487E),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 600;

          return isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 200.w,
                        height: 200.w,
                        child: SvgPicture.asset('assets/images/svg/logo.svg')),
                    Padding(
                      padding: EdgeInsets.only(top: 48.w),
                      child: Text(
                        'Roller&Braceta',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.w,
                            fontStyle: FontStyle.italic),
                      ),
                    )
                  ],
                )
              : Container();
        }),
      ),
    );
  }
}
