import 'package:flutter/material.dart';

class MobileFloatingActionButtonWidget extends StatelessWidget {
  const MobileFloatingActionButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.replay_outlined,
        color: Colors.black,
      ),
    );
  }
}
