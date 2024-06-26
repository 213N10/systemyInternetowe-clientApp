import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:systemy_mobilne/classes/question.dart';
import 'package:systemy_mobilne/classes/user.dart';
import 'user_answer.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class ScanScreen extends StatefulWidget {
  final String ip;
  final String token;
  final User user;
  const ScanScreen({super.key, required this.user, required this.ip, required this.token});

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
              fontSize: 28.0
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: MobileScanner(
                allowDuplicates: false,
                onDetect: (barcode, args) async {
                  final String? code = barcode.rawValue;
                  //print(code);
                  final response = await fetchQuestion(code!);
                  
                  final data = jsonDecode(response.body);
                  final question = Question.fromJson(data);
                  //print(question.question);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserAnswer(question: question, user:widget.user, ip:widget.ip,token: widget.token)),
                    );
            },
          ), 
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
    //print('Scan QR Code');
    final response = await fetchQuestion("W1");
    final data = jsonDecode(response.body);
    final question = Question.fromJson(data);
    //print(question.question);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserAnswer(question: question, user:widget.user, ip:widget.ip,token: widget.token,)),
      );
  }

  Future<http.Response> fetchQuestion(String wydzial) async {
    final url = "${widget.ip}/api/questions/random/?location=$wydzial";
    final response = await http.get(Uri.parse(url),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${widget.token}',
    });
    if (response.statusCode == 200) {
      //print('Questions fetched');
      return response;
    }
    else {
      //print('Failed to fetch questions');
      return response;
    }
  }




}