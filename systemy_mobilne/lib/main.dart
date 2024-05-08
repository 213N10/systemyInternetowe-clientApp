import 'package:flutter/material.dart';
import 'pages/login_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kreatywna nazwa aplikacji',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          //brightness: Brightness.dark,//może walnąć przełącznik jasny/ciemny
          seedColor: const Color.fromARGB(255, 9, 112, 196),
          primary: const Color.fromARGB(255, 29, 238, 81), 
          ),
      ),
      home: const LoginScreen(),
    );
  }
}
