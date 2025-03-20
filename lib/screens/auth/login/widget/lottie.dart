import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child: Lottie.asset(
      "assets/login.json",
      height: 200,
      width: 200,
      repeat: true,
      reverse: true
      ));
  }
}

