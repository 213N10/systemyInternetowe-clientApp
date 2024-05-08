import 'package:flutter/material.dart';
import 'package:systemy_mobilne/classes/user.dart';
import '../homepage.dart';
import 'register_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static const String _url = 'http://127.0.0.1:8000/login/';


  Future<void> checkUserdata() async {
    final String _username = _usernameController.text;
    final String _password = _passwordController.text;
    print(_username);
    final _response = await loginUser(_username, _password);
    print(_response.statusCode);
    if (_response.statusCode == 200){
      final _data = jsonDecode(_response.body);
      final String _token = _data['token'];
      final User _user = User.fromJson(_data['user']);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage(user: _user,token: _token)),
      );
    }
    else{
      print('Failed to log in');
    }
    
    
  }


  Future<http.Response> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      })
      
    );
    if (response.statusCode == 200) {
      print('User logged in');
      return response;
    } 
    else {
      print("Failed to log in");
      return response;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Login'),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  prefixText: 'Username: ',
                ),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixText: 'Password: ',
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    child: const Text('Register'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      checkUserdata();
                    },
                    child: const Text('Login'),
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  }
}