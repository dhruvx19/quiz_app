class QuizResultModel {
  final String userId;
  final int score;
  final int totalQuestions;
  final double percentage;
  final DateTime completedAt;
  final bool passed;

  QuizResultModel({
    required this.userId,
    required this.score,
    required this.totalQuestions,
    required this.percentage,
    required this.completedAt,
    required this.passed,
  });

  factory QuizResultModel.fromMap(Map<String, dynamic> map) {
    return QuizResultModel(
      userId: map['userId'] ?? '',
      score: map['score'] ?? 0,
      totalQuestions: map['totalQuestions'] ?? 0,
      percentage: (map['percentage'] ?? 0.0).toDouble(),
      completedAt: DateTime.fromMillisecondsSinceEpoch(map['completedAt'] ?? 0),
      passed: map['passed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'score': score,
      'totalQuestions': totalQuestions,
      'percentage': percentage,
      'completedAt': completedAt.millisecondsSinceEpoch,
      'passed': passed,
    };
  }
}
