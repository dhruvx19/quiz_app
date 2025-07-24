import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/auth_provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/screens/quiz_screen/result_screen.dart';
import 'package:quiz_app/widgets/quiz/quiz_scaffold.dart';
import 'package:quiz_app/widgets/quiz/quiz_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false).startQuiz();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    if (_animationController.isAnimating) {
      _animationController.stop();
    }

    super.dispose();
  }

  void newQuestion() {
    _animationController.reset();
    _animationController.forward();
  }

  void submitAnswer(QuizProvider quizProvider) {
    quizProvider.submitAnswer();

    if (!quizProvider.quizCompleted) {
      newQuestion();
    }
  }

  void results() async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.user != null) {
      await quizProvider.result(authProvider.user!.uid);
    }

    _animationController.dispose();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ResultScreen()),
      );
    }
  }

  void exitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Exit Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(
          'Your progress will be lost. Are you sure?',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Continue', style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 117, 94, 184),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuizScaffold(
      glowType: GlowType.primary,
      glowDuration: const Duration(milliseconds: 1000),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.quizCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(Duration(milliseconds: 100), () {
                results();
              });
            });
          }

          if (quizProvider.currentQuestion == null) {
            return Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return Column(
            children: [
              SizedBox(height: 30),

              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: exitDialog,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${quizProvider.currentIndex + 1}/${quizProvider.questions.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.bounceOut,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              '${quizProvider.score}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                      alignment: Alignment.centerLeft,
                      width: 0.9 * quizProvider.progress,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      quizProvider.currentQuestion!.question!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: SlideTransition(
                  position:
                      Tween<Offset>(
                        begin: Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeOut,
                        ),
                      ),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF7C3AED).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                quizProvider.currentQuestion!.category ??
                                    'General',
                                style: TextStyle(
                                  color: Color(0xFF7C3AED),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          Expanded(
                            child: ListView.separated(
                              itemCount: quizProvider
                                  .currentQuestion!
                                  .allOption
                                  .length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                String option = quizProvider
                                    .currentQuestion!
                                    .allOption[index];
                                bool isSelected =
                                    quizProvider.selectedAnswer == option;

                                return AnimatedBuilder(
                                  animation: _animationController,
                                  builder: (context, child) {
                                    final delay = index * 0.1;
                                    final animValue =
                                        (_animationController.value - delay)
                                            .clamp(0.0, 1.0);

                                    return Transform.translate(
                                      offset: Offset(0, 20 * (1 - animValue)),
                                      child: Opacity(
                                        opacity: animValue,
                                        child: GestureDetector(
                                          onTap: () =>
                                              quizProvider.selectAnswer(option),
                                          child: AnimatedContainer(
                                            duration: Duration(
                                              milliseconds: 200,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? Color(
                                                      0xFF7C3AED,
                                                    ).withOpacity(0.1)
                                                  : Colors.grey.shade50,
                                              border: Border.all(
                                                color: isSelected
                                                    ? Color(0xFF7C3AED)
                                                    : Colors.grey.shade300,
                                                width: isSelected ? 2 : 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              children: [
                                                AnimatedContainer(
                                                  duration: Duration(
                                                    milliseconds: 200,
                                                  ),
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: isSelected
                                                        ? Color(0xFF7C3AED)
                                                        : Colors.transparent,
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? Color(0xFF7C3AED)
                                                          : Colors
                                                                .grey
                                                                .shade400,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: isSelected
                                                      ? Icon(
                                                          Icons.check,
                                                          size: 12,
                                                          color: Colors.white,
                                                        )
                                                      : null,
                                                ),
                                                SizedBox(width: 16),
                                                Expanded(
                                                  child: Text(
                                                    option,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: isSelected
                                                          ? FontWeight.w600
                                                          : FontWeight.w500,
                                                      color: isSelected
                                                          ? Color(0xFF7C3AED)
                                                          : Colors
                                                                .grey
                                                                .shade700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: 20),

                          AnimatedScale(
                            scale: quizProvider.selectedAnswer != null
                                ? 1.0
                                : 0.95,
                            duration: Duration(milliseconds: 200),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: QuizButton(
                                onPressed: quizProvider.selectedAnswer != null
                                    ? () => submitAnswer(quizProvider)
                                    : null,

                                child: Text(
                                  quizProvider.currentIndex ==
                                          quizProvider.questions.length - 1
                                      ? 'Finish Quiz'
                                      : 'Next Question',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
