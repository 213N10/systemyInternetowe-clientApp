// Summary: This file contains the userQuestion class, which is used to store the user's answers to the questions.
class UsersAnswers {
  final int userId;
  final String question;

  final bool isCorrect;
  final int points;

  UsersAnswers({required this.userId, required this.question, required this.isCorrect, required this.points});


  UsersAnswers.fromJson(Map<String, dynamic> json) 
  :
    userId = json['user'] as int,
    question = json['question'] as String,
    isCorrect = (json['result'] as bool),
    points = json['points'] as int;
  
  Map<String, dynamic> toJson() => {
    'user': userId,
    'question': question,
    'result': isCorrect,
    'points': points,
  };
}