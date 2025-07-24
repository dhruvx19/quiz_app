import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quiz_app/provider/auth_provider.dart';
import 'package:quiz_app/screens/quiz_screen/home_screen.dart';
import 'package:quiz_app/screens/auth/login_screen.dart';
import 'package:quiz_app/screens/auth/registration_screen.dart';
import 'package:quiz_app/widgets/quiz/quiz_button.dart';
import 'package:quiz_app/widgets/quiz/quiz_gradient_text.dart';
import 'package:quiz_app/widgets/quiz/quiz_illutrator.dart';
import 'package:quiz_app/widgets/quiz/quiz_scaffold.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void login() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            AuthProvider().isAuthenticated ? HomeScreen() : LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  void register() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            RegisterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero)
                .animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuizScaffold(
      glowType: GlowType.primary,
      glowDuration: const Duration(milliseconds: 1000),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Column(
              children: [
                SizedBox(height: 40),

                Expanded(
                  flex: 3,
                  child: Animate(
                    effects: const [
                      FadeEffect(
                        delay: Duration(milliseconds: 200),
                        duration: Duration(milliseconds: 1000),
                      ),
                      ScaleEffect(
                        begin: Offset(0.8, 0.8),
                        end: Offset(1.0, 1.0),
                        curve: Curves.elasticOut,
                        duration: Duration(milliseconds: 1200),
                      ),
                    ],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: 1.0 + (_pulseController.value * 0.05),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(
                                        255,
                                        117,
                                        94,
                                        184,
                                      ).withOpacity(0.3),
                                      blurRadius:
                                          20 + (_pulseController.value * 10),
                                      spreadRadius:
                                          2 + (_pulseController.value * 3),
                                    ),
                                  ],
                                ),
                                child: const QuizIllustration(
                                  illustration: 'assets/images/logo.png',
                                  width: 180,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 32),

                        QuizGradientText(
                              text: 'Welcome to Quiz',
                              colors: [
                                Color.fromARGB(255, 117, 94, 184),
                                Color.fromARGB(255, 252, 252, 252),
                              ],
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'SF Pro Display',
                                decoration: TextDecoration.none,
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 400.ms, duration: 800.ms)
                            .slideY(begin: -0.3, end: 0, curve: Curves.easeOut),

                        const SizedBox(height: 16),

                        Text(
                              'Test your knowledge and\nchallenge your mind',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 600.ms, duration: 800.ms)
                            .slideY(begin: 0.3, end: 0, curve: Curves.easeOut),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Animate(
                          effects: const [
                            FadeEffect(
                              delay: Duration(milliseconds: 1200),
                              duration: Duration(milliseconds: 500),
                            ),
                            SlideEffect(
                              begin: Offset(0, 0.5),
                              end: Offset.zero,
                              curve: Curves.elasticOut,
                              duration: Duration(milliseconds: 800),
                            ),
                          ],
                          child: QuizButton(
                            label: 'Get Started',
                            onPressed: login,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        Animate(
                          effects: const [
                            FadeEffect(
                              delay: Duration(milliseconds: 1400),
                              duration: Duration(milliseconds: 500),
                            ),
                          ],
                          child: GestureDetector(
                            onTap: register,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
