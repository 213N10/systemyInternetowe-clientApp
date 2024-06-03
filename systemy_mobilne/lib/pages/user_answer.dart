import 'package:flutter/material.dart';
import 'package:systemy_mobilne/classes/question.dart';
import 'package:systemy_mobilne/classes/user.dart';
import 'package:systemy_mobilne/classes/users_answers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserAnswer extends StatefulWidget {
  final Question question;
  final String ip;
  final User user;
  const UserAnswer({super.key, required this.question, required this.user, required this.ip});

  @override
  State<UserAnswer> createState() => _UserAnswerState();
}

class _UserAnswerState extends State<UserAnswer> {

  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Answer'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.question.question),
            Text("1. ${widget.question.option_1}"),
            Text("2. ${widget.question.option_2}"),
            Text("3. ${widget.question.option_3}"),
            Text("4. ${widget.question.option_4}"),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                hintText: 'Answer'
              ),
            ),
            ElevatedButton(onPressed: onPressed, child: const Text('Check Answer'))
          ],
        ), 

      ),
    );
  }




  void onPressed() {
    setState(() {
      if (_answerController.text == widget.question.correct_answer) {
        print('Correct Answer');
        UsersAnswers userAnswer = UsersAnswers(userId: widget.user.id, question: widget.question.question, isCorrect: true, points: widget.question.points_for_question);
        print(userAnswer.toJson());
        postAnswer(userAnswer);
      }
      else {
        print('Wrong Answer');
        UsersAnswers userAnswer = UsersAnswers(userId: widget.user.id, question: widget.question.question, isCorrect: false, points: 0);
        print(userAnswer.toJson());
        postAnswer(userAnswer);
      }
    });
  }


  Future<http.Response>postAnswer(UsersAnswers userAnswer) async {
    final response = await http.post(
      Uri.parse("${widget.ip}/api/user-answers/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userAnswer.toJson()),
    );
    if (response.statusCode == 201) {
      print('Answer posted');
      return response;
    } 
    else {
      print("Failed to post answer");
      return response;
    }
  }


}