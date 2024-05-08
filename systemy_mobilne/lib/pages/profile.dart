import 'package:flutter/material.dart';
import 'package:systemy_mobilne/classes/user.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  
  
  @override
  Widget build(BuildContext context) {

    return Center(
      child:Column(
        children: [
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Change your username',
              prefixText: 'New username: ',
              hintText: widget.user.username,
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Change your password',
              prefixText: 'New password: ',
              hintText: widget.user.password,
            ),
          ),
          
        ]
      )
      
    );
  }
}