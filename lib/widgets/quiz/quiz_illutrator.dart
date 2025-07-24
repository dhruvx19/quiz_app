import 'package:flutter/material.dart';

class QuizIllustration extends StatelessWidget {
  const QuizIllustration({
    super.key,
    required this.illustration,
    this.height,
    this.width,
    this.fit,
    this.color,
  });

  final String illustration;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(illustration,
        height: height, width: width, fit: fit, color: color);
  }
}
