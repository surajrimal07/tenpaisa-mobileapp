import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedLoading extends StatelessWidget {
  final String path;
  final double width;
  final double height;

  const AnimatedLoading(
      {super.key,
      required this.path,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      path,
      repeat: true,
      frameRate: FrameRate.max,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
  }
}

class LoadingAnimation extends StatelessWidget {
  final Color color;

  const LoadingAnimation({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}
