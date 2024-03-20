import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 18.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: SvgPicture.asset('assets/images/svg/logo.svg'),
            ),
            const Text(
              '\nCentro Universitário Senac\n\nPI8 - App de monitoramento\n\nGuilherme Chiquito\nHenrique Jorge\nIgor Giuliano\nLucas Sampaio\nMateus Porto\nPaulo Vaamond\nRubens Prado\n\n1.0.0 ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
