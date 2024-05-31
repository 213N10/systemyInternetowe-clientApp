class Question {
  String question;
  int points_for_question;
  String correct_answer;
  String option_1 ;
  String option_2;
  String option_3;
  String option_4;
  String locations;

  Question({required this.question, required this.points_for_question, required this.correct_answer, required this.option_1, required this.option_2, required this.option_3, required this.option_4, required this.locations});

  Question.fromJson(Map<String, dynamic> json)
  :
    question = json['question'] as String,

    points_for_question = json['points_for_question'] as int,
    correct_answer = json['correct_answer'] as String,
    option_1 = json['option_1'] as String,
    option_2 = json['option_2'] as String,
    option_3 = json['option_3'] as String,
    option_4 = json['option_4'] as String,
    locations = json['locations'] as String;


  Map<String, dynamic> toJson() => {
    'question': question,
    'points_for_question': points_for_question,
    'correct_answer': correct_answer,
    'option_1': option_1,
    'option_2': option_2,
    'option_3': option_3,
    'option_4': option_4,
    'locations': locations,
  };
}