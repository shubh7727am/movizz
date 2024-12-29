import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final String lottieFilePath;
  final double? width;
  final double? height;

  const LoadingWidget({
    super.key,
    required this.lottieFilePath,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        lottieFilePath,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }
}
