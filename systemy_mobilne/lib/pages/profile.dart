import 'package:flutter/material.dart';
import 'package:systemy_mobilne/classes/user.dart';
import "package:systemy_mobilne/pages/login_screen.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';



class Profile extends StatefulWidget {
  final User user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  late String url;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _usernameCheckController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailCheckController = TextEditingController();


  @override
  void initState() {
    super.initState();
    url = "http://192.168.100.46:8000/api/users/${widget.user.id}/";
    //print(url);
  }
  
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView( 
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Column(
        children: [
          const Text(
            'Ustawienia konta',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0
            ),
          ),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Change your username',
              prefixText: 'New username: ',
              
            ),
          ),
          const SizedBox(height: 5), // Przerwa między polem tekstowym a przyciskiem
          TextField(
            controller: _usernameCheckController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Repeat your new username',
              prefixText: 'New username: ',
              
            ),
            
          ),
          const SizedBox(height: 10), // Przerwa między polem tekstowym a przyciskiem
          ElevatedButton(
            onPressed:() async {
              
              if (_usernameController.text == _usernameCheckController.text){
                final response = await http.patch(
                  Uri.parse(url),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'username': _usernameController.text,
                  }),
                );
                
                
                if (response.statusCode == 200){
                  print('Username changed');
                  print(response.body); // Zwraca zmienionego użytkownika (zaktualizowanego
                  widget.user.username = _usernameController.text;
                  print(widget.user.username);
                }
                else {
                  print('Failed to change username');
                }
              }
              else {
                print('Username does not match');
              }
            },
             
          child: const Text('Change username')
          ),



          const SizedBox(height: 20), // Przerwa między polem tekstowym a przyciskiem
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Change your password',
              prefixText: 'New password: ',
              
            ),
          ),

          const SizedBox(height: 5), // Przerwa między polem tekstowym
          TextField(
            controller: _passwordCheckController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Repeat your new password',
              prefixText: 'New password: ',
              
            ),
          ),
          const SizedBox(height: 10), // Przerwa między polem tekstowym a przyciskiem
          ElevatedButton(
            onPressed:() async {
              if (_passwordController.text == _passwordCheckController.text){
                final response = await http.patch(
                  Uri.parse(url),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'password': _passwordController.text,
                  }),
                );
                if (response.statusCode == 200){
                  print('Password changed');
                  print(response.body); // Zwraca zmienionego użytkownika (zaktualizowanego
                  widget.user.password = _passwordController.text;
                }
                else {
                  print('Failed to change password');
                }
              }
              else {
                print('Password does not match');
              }
            },
             
          child: const Text('Change password')
          ),
          


          const SizedBox(height: 20), // Przerwa między polem tekstowym a przyciskiem
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Change your email',
              prefixText: 'New email: ',
              
            ),
          ),

          const SizedBox(height: 5), // Przerwa między polem tekstowym
          TextField(
            controller: _emailCheckController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Repeat your new email',
              prefixText: 'New email: ',
              
            ),
          ),
          const SizedBox(height: 10), // Przerwa między polem tekstowym a przyciskiem
          ElevatedButton(
            onPressed:() async {
              if (_emailController.text == _emailCheckController.text){
                final response = await http.patch(
                  Uri.parse(url),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'email': _emailController.text,
                  }),
                );
                if (response.statusCode == 200){
                  print('Email changed');
                  print(response.body); // Zwraca zmienionego użytkownika (zaktualizowanego
                  widget.user.email = _emailController.text;
                }
                else {
                  print('Failed to change email');
                }
              }
              else {
                print('Email does not match');
              } 
            },
             
          child: const Text('Change email')
          ),

          ElevatedButton(onPressed:() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
          }, 
          child: const Text('Logout')
          ),
          
        ]
      )
      )
    )
    );
  }
}