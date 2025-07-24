class QuizQAModel {
  int? responseCode;
  List<Results>? results;

  QuizQAModel({this.responseCode, this.results});

  QuizQAModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response_code'] = responseCode;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? type;
  String? difficulty;
  String? category;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;
  List<String>? allOptions;

  Results({
    this.type,
    this.difficulty,
    this.category,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  Results.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    difficulty = json['difficulty'];
    category = json['category'];
    question = _decodeHtml(json['question']);
    correctAnswer = _decodeHtml(json['correct_answer']);
    incorrectAnswers = (json['incorrect_answers'] as List)
        .map((e) => _decodeHtml(e.toString()))
        .toList();

    allOptions = [...incorrectAnswers!, correctAnswer!];
    allOptions!.shuffle();
  }

  List<String> get allOption {
    if (allOptions == null) {
      allOptions = [...(incorrectAnswers ?? []), correctAnswer ?? ''];
      allOptions!.shuffle();
    }
    return allOptions!;
  }

  String _decodeHtml(String htmlString) {
    return htmlString
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['difficulty'] = difficulty;
    data['category'] = category;
    data['question'] = question;
    data['correct_answer'] = correctAnswer;
    data['incorrect_answers'] = incorrectAnswers;
    return data;
  }
}
