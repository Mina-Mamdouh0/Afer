class Question {
  String?id;
  String?question;
  String?answer1;
  String?answer2;
  String?answer3;
  String?answer4;
  String?correctAnswer;

  Question(
      {this.id, this.question, this.answer1, this.answer2, this.answer3, this.answer4, this.correctAnswer});
  Question.fromJson(json) {
    id = json['id'];
    question = json['question'];
    answer1 = json['answer1'];
    answer2 = json['answer2'];
    answer3 = json['answer3'];
    answer4 = json['answer4'];
    correctAnswer = json['correctAnswer'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'question': question,
      'answer1' : answer1,
      'answer2' : answer2,
      'answer3': answer3,
      'answer4' : answer4,
      'correctAnswer': correctAnswer,
    };
  }
}