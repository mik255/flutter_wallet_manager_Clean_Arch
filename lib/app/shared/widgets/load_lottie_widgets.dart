import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoader extends StatelessWidget {
  final String animationPath;
  final BoxFit fit;
  final bool loop;
  final double width;
  final double height;

  const LottieLoader({
    Key? key,
    required this.animationPath,
    this.fit = BoxFit.contain,
    this.loop = true,
    this.width = 200.0,
    this.height = 200.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Lottie.asset(
        animationPath,
        fit: fit,
        repeat: loop ? true : false,
        animate: true,
      ),
    );
  }
}
