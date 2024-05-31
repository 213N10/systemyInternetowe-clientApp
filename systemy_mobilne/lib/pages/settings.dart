import "package:flutter/material.dart";
import "package:systemy_mobilne/pages/login_screen.dart";


class Logout extends StatelessWidget {
  const Logout({super.key});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
    }, child: const Text('Logout'));


}
}