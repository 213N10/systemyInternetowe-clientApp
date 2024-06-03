import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../classes/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class RegisterPage extends StatefulWidget {
  final String ip;
  const RegisterPage({super.key, required this.ip});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  late String _url;

  @override
  void initState() {
    super.initState();
    _url = '${widget.ip}/api/users/';
  }
  User? _user;
  
  void checkUserdata(){
    setState(() {
      if(_passwordController.text == _repeatPasswordController.text){
        _user = User(username: _usernameController.text, email: _emailController.text, password: _passwordController.text);
        var response = createUser(_user!);
        print(response);
      } else {
        print('Passwords do not match');
        }
      }
    );
  }

  Future<http.Response?> createUser(User user) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201) {
      print('User created');
      return response;
    } 
    else {
      print("Failed to create user");
      return null;
    }
    
  }
    
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Register'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller : _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'username',
                hintText: 'username: ',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Email: ',
              ),
            ),
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Password: ',
              ),
            ),
            TextField(
              obscureText: true,
              controller: _repeatPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Repeat Password',
                hintText: 'Password: ',
              ),
            ),
            ElevatedButton(
              onPressed: checkUserdata, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              )
            ),
            
          ],
        ),
      ),
    );
  }
}