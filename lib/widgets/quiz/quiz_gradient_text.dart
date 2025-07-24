import 'package:flutter/cupertino.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class QuizGradientText extends StatelessWidget {
  const QuizGradientText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    required this.colors,
    this.stops,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final List<Color> colors;
  final List<double>? stops;
  @override
  Widget build(BuildContext context) {
    return GradientText(
      text,
      colors: colors,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      stops: stops,
    );
  }
}
