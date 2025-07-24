import 'dart:ui';

import 'package:flutter/material.dart';



 String resultMessage(double percentage) {
    if (percentage >= 90) {
      return 'You\'re a quiz master! Amazing performance with excellent understanding.';
    }
    if (percentage >= 80) {
      return 'Fantastic job! You clearly understand the material very well.';
    }
    if (percentage >= 70) {
      return 'Nice work! You have a solid grasp of the concepts.';
    }
    if (percentage >= 50) {
      return 'You\'re on the right track! A bit more practice will help you improve.';
    }
    return 'Every expert was once a beginner. Keep practicing and you\'ll get there!';
  }




  List<Color> scoreColors(double percentage) {
    if (percentage >= 90) return [Colors.amber, Colors.orange];
    if (percentage >= 80) return [Colors.green, Colors.lightGreen];
    if (percentage >= 70) return [Colors.blue, Colors.lightBlue];
    if (percentage >= 50) return [Colors.orange, Colors.deepOrange];
    return [Colors.purple, Colors.deepPurple];
  }

  String titles (double percentage) {
    if (percentage >= 90) return 'Outstanding! 🌟';
    if (percentage >= 80) return 'Great Work! 👏';
    if (percentage >= 70) return 'Well Done! 🎉';
    if (percentage >= 50) return 'Good Effort! 💪';
    return 'Keep Learning! 📚';
  }
