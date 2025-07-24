import 'package:flutter/material.dart';

class QuizButton extends StatelessWidget {
  final String label;
  final Widget? leading;
  final Widget? child;
  final VoidCallback? onPressed;
  final Size? size;
  final bool isLoading;
  final Color? borderColor;
  final Color? textColor;
  final OutlinedBorder? shape;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;

  const QuizButton({
    super.key,
    this.label = '',
    this.leading,
    this.onPressed,
    this.size,
    this.child,
    this.isLoading = false,
    this.borderColor,
    this.textColor,
    this.shape,
    this.backgroundColor,
    this.disabledBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =  Color.fromARGB(255, 117, 94, 184);
    
    if (isLoading) {
      return QuizButton(
        onPressed: null,
        
        child: SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.2,
            color: textColor ?? Colors.white,
          ),
        ),
      );
    }
    
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: shape,
        side: borderColor != null
            ? BorderSide(color: borderColor!, width: 0.33)
            : (onPressed == null ? null : BorderSide(
                color: backgroundColor.withOpacity(0.3),
                width: 0.33,
              )),
        padding: const EdgeInsets.symmetric(vertical: 12),
        elevation: 0,
        backgroundColor: onPressed == null 
            ? (disabledBackgroundColor ?? Colors.grey.shade300)
            : backgroundColor,
        fixedSize: size,
        shadowColor: Colors.transparent,
      ),
      child: child ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) leading!,
              if (leading != null) const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: onPressed == null
                      ? Colors.grey.shade400
                      : textColor ?? Colors.white, 
                ),
              ),
            ],
          ),
    );
  }
}