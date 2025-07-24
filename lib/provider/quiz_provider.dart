import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/constants/api_constants.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/models/result_model.dart';

class QuizProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Results> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isLoading = false;
  String? _errorMessage;
  bool _quizStarted = false;
  bool _quizCompleted = false;
  String? _selectedAnswer;

  List<Results> get questions => _questions;
  int get currentIndex => _currentIndex;
  int get score => _score;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get quizStarted => _quizStarted;
  bool get quizCompleted => _quizCompleted;
  String? get selectedAnswer => _selectedAnswer;
  Results? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentIndex] : null;
  double get progress =>
      _questions.isEmpty ? 0.0 : (_currentIndex + 1) / _questions.length;

  Future<bool> loadQuiz() async {
    try {
      setLoading(true);

      final response = await http.get(Uri.parse(ApiConstants.apiUrl));

      if (response.statusCode == 200) {
        final quiz = json.decode(response.body);
        final quizData = QuizQAModel.fromJson(quiz);
        if (quizData.responseCode == 0 && quizData.results != null) {
          _questions = quizData.results!;
          resetQuiz();
          setLoading(false);
          return true;
        }
      }

      throw Exception('Failed to load questions');
    } catch (e) {
      SnackBar(content: Text('Error loading quiz: ${e.toString()}'));
      setLoading(false);
      return false;
    }
  }

  void startQuiz() {
    _quizStarted = true;
    _quizCompleted = false;
    _currentIndex = 0;
    _score = 0;
    _selectedAnswer = null;
    notifyListeners();
  }

  void selectAnswer(String answer) {
    _selectedAnswer = answer;
    notifyListeners();
  }

  void submitAnswer() {
    if (_selectedAnswer != null && currentQuestion != null) {
      if (_selectedAnswer == currentQuestion!.correctAnswer) {
        _score++;
      }

      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _selectedAnswer = null;
      } else {
        completedQuiz();
      }
      notifyListeners();
    }
  }

  void completedQuiz() {
    _quizCompleted = true;
    _quizStarted = false;
    notifyListeners();
  }

  Future<void> result(String userId) async {
    try {
      double percentage = (score / questions.length) * 100;
      bool passed = percentage >= 70;

      QuizResultModel result = QuizResultModel(
        userId: userId,
        score: score,
        totalQuestions: questions.length,
        percentage: percentage,
        completedAt: DateTime.now(),
        passed: passed,
      );

      await _firestore.collection('quiz_results').add(result.toMap());
    } catch (e) {
      SnackBar(content: Text('Error loading quiz: ${e.toString()}'));
    }
  }

  void resetQuiz() {
    _currentIndex = 0;
    _score = 0;
    _quizStarted = false;
    _quizCompleted = false;
    _selectedAnswer = null;
  }

  void newQuiz() {
    resetQuiz();
    _questions.clear();
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
