import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:systemy_mobilne/classes/question.dart';
import 'package:systemy_mobilne/classes/user.dart';
import 'user_answer.dart';


class ScanScreen extends StatefulWidget {
  final User user;
  const ScanScreen({super.key, required this.user});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  String qrCode = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Scan Screen',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0
            ),
          ),
          ElevatedButton(
            onPressed: testownie, 
            child: const Text('Scan QR Code'))
        ]
      ),
    );
  }


  void testownie() async {
    print('Scan QR Code');
    final response = await fetchQuestion();
    final data = jsonDecode(response.body);
    final question = Question.fromJson(data);
    print(question.question);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserAnswer(question: question, user:widget.user)),
      );
  }

  Future<http.Response> fetchQuestion() async {
    const url = "http://192.168.100.46:8000/api/questions/random/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Questions fetched');
      return response;
    }
    else {
      print('Failed to fetch questions');
      return response;
    }
  }




}