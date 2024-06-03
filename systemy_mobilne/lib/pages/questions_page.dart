import 'package:flutter/material.dart';
import 'package:systemy_mobilne/classes/user.dart';
import 'package:systemy_mobilne/classes/users_answers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key, required this.user, required this.ip});
  final User user;
  final String ip;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final List<UsersAnswers> userAnswers = [];
  int userPoints = 0;

  String baseUrl = "";

  @override
  void initState() {
    super.initState();
    baseUrl = "${widget.ip}/api/user-answers/";
    getAnswers(widget.user.id);
  }


  Future<void> getAnswers(int id) async {
    final response = await http.get(Uri.parse("$baseUrl?user_id=${widget.user.id}"));
    if (response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      for (var item in data){
        //print(item);
        setState(() {
          userAnswers.add(UsersAnswers.fromJson(item));
          userPoints += item['points'] as int;
        });
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Odpowiedzi użytkownika',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            height: 50,
            margin: const EdgeInsets.all(5),
            color: const Color.fromARGB(255, 236, 5, 198),
            child: Center(
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Pytanie:',
                      textAlign: TextAlign.center,
                      ),
                    
                  ),
                  
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'Poprawna:',
                      textAlign: TextAlign.center,
                      ),
                    
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Punkty: ${userPoints.toString()}',
                      textAlign: TextAlign.center,
                      ),
                    
                  ),
                ],
              ),
              
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),

            itemCount: userAnswers.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
                padding: const EdgeInsets.all(5),
                height: 50,
                margin: const EdgeInsets.all(5),
                color: Colors.amber[600],
                child: Center(child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        userAnswers[index].question,
                        textAlign: TextAlign.center,
                        maxLines: null,
                      ),
                    ),
                    
                    Expanded(
                      flex: 1,
                      child: Text(
                        userAnswers[index].isCorrect.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        userAnswers[index].points.toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  ),
                  
                  ),
              );
              
            }
          )
        ],
        )

        
      ),
    );
}
}