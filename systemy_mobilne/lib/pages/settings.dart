import "package:flutter/material.dart";
import "package:systemy_mobilne/pages/login_screen.dart";


class Logout extends StatelessWidget {
  final String ip;
  const Logout({super.key, required this.ip});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen(ip:ip)),
        );
    }, child: const Text('Logout'));


}
}