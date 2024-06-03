import 'package:flutter/material.dart';
import 'package:systemy_mobilne/classes/user.dart';
import 'homepage.dart';
import 'register_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  final String ip;
  const LoginScreen({super.key, required this.ip});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  


  Future<void> checkUserdata() async {
    final String _username = _usernameController.text;
    final String _password = _passwordController.text;
    
    final _response = await loginUser(_username, _password);
    print(_response.statusCode);
    if (_response.statusCode == 200){
      final _data = jsonDecode(_response.body);
      final String _token = _data['token'];
      final User _user = User.fromJson(_data['user']);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage(user: _user,token: _token, ip: widget.ip,)),
      );
    }
    else{
      print('Failed to log in');
    }
    
    
  }


  Future<http.Response> loginUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('${widget.ip}/login/'),
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
                        MaterialPageRoute(builder: (context) => RegisterPage(ip:widget.ip)),
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