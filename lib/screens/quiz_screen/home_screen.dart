import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/auth_provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/screens/auth/login_screen.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quiz_app/widgets/quiz/quiz_button.dart';
import 'package:quiz_app/widgets/quiz/quiz_card.dart';
import 'package:quiz_app/widgets/quiz/quiz_gradient_text.dart';
import 'package:quiz_app/widgets/quiz/quiz_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return QuizScaffold(
      glowType: GlowType.primary,
      glowDuration: const Duration(milliseconds: 1000),
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return Text(
                            authProvider.user?.displayName ?? 'User',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: logoutDialog,
                    icon: Icon(Icons.logout, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            QuizGradientText(
              text: 'Quiz Challenge',
              colors: [
                Color.fromARGB(255, 117, 94, 184),
                Color.fromARGB(255, 252, 252, 252),
              ],
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.none,
              ),
            ),

            const SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFF7C3AED).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.quiz,
                        size: 60,
                        color: Color(0xFF7C3AED),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Text(
                      'Ready for a Challenge?',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),
                    Text(
                      'Test your knowledge with 10 random questions\nand see how well you can score!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        QuizCards(
                          icon: Icons.quiz_outlined,
                          title: '10',
                          subtitle: 'Questions',
                        ),
                        QuizCards(
                          icon: Icons.timer_outlined,
                          title: '30s',
                          subtitle: 'Per Question',
                        ),
                        QuizCards(
                          icon: Icons.star_outline,
                          title: 'Score',
                          subtitle: 'Your Best',
                        ),
                      ],
                    ),

                    const Spacer(),
                    Consumer<QuizProvider>(
                      builder: (context, quizProvider, child) {
                        return SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: QuizButton(
                            onPressed: quizProvider.isLoading
                                ? null
                                : _startQuiz,

                            child: quizProvider.isLoading
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Loading Quiz...',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.play_arrow,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Start Quiz',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startQuiz() async {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    bool success = await quizProvider.loadQuiz();

    if (success) {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => QuizScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(quizProvider.errorMessage ?? 'Failed to load quiz'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void logoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Logout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Provider.of<AuthProvider>(context, listen: false).signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 117, 94, 184),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
