class Question {
  String question;
  int pointsForQuestion;
  String correctAnswer;
  String option_1 ;
  String option_2;
  String option_3;
  String option_4;
  String locations;

  Question({required this.question, required this.pointsForQuestion, required this.correctAnswer, required this.option_1, required this.option_2, required this.option_3, required this.option_4, required this.locations});

  Question.fromJson(Map<String, dynamic> json)
  :
    question = json['question'] as String,

    pointsForQuestion = json['points_for_question'] as int,
    correctAnswer = json['correct_answer'] as String,
    option_1 = json['option_1'] as String,
    option_2 = json['option_2'] as String,
    option_3 = json['option_3'] as String,
    option_4 = json['option_4'] as String,
    locations = json['locations'] as String;


  Map<String, dynamic> toJson() => {
    'question': question,
    'points_for_question': pointsForQuestion,
    'correct_answer': correctAnswer,
    'option_1': option_1,
    'option_2': option_2,
    'option_3': option_3,
    'option_4': option_4,
    'locations': locations,
  };
}