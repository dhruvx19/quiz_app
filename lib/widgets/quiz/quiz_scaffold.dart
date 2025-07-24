import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/quiz_ui/quiz_assets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizScaffold extends StatelessWidget {
  final GlowType? glowType;
  final Duration? glowDuration;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final Widget? floatingActionButton;
  
  const QuizScaffold({
    super.key,
    this.glowType,
    this.glowDuration,

    this.body,
    this.bottomNavigationBar,
    this.extendBody = false,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      child: Container(
        decoration: glowType != null
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(glowType!.assetPath),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: Animate(
          effects: glowType != null
              ? [
                  FadeEffect(
                    duration: glowDuration ?? const Duration(milliseconds: 1000),
                  )
                ]
              : [],
          child: Scaffold(
            backgroundColor: Colors.transparent,
          
            body: body,
            extendBody: extendBody,
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
          ),
        ),
      ),
    );
  }
}

enum GlowType {
  primary(QuizAssets.bgGlowPrimary),
  success(QuizAssets.bgGlowSuccess),
  dest(QuizAssets.bgGlowDest),
  failed(QuizAssets.bgGlowFailed);

  final String assetPath;
  const GlowType(this.assetPath);
}
