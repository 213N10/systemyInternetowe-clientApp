import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:systemy_mobilne/classes/user.dart';
import 'profile.dart';
//import 'settings.dart';
import 'questions_page.dart';
import 'scan_qr.dart';

class Homepage extends StatefulWidget{
  final User user;
  final String token;
  final String ip;
  const Homepage({super.key, required this.user, required this.token, required this.ip});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _selectedIndex = 0;
  late List<Widget> _pages;
  void printIndex(int index){
    setState(() {
      _selectedIndex = index;
      //print(index);
    });
  }
  @override
  void initState(){
    super.initState();
    _pages = [
    ScanScreen(user: widget.user, ip: widget.ip,token: widget.token),
    QuestionsPage(user: widget.user, ip: widget.ip, token: widget.token),
    Profile(user: widget.user, ip: widget.ip, token: widget.token),
    //const Center(child: Logout()),
  ];
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Gra Terenowa'),
      ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        gap : 8,
        onTabChange: printIndex,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Home",
            ),
          GButton(
            icon: Icons.question_mark,
            text: "questions",
            ),
          GButton(
            icon: Icons.person, 
            text: "Profile"
          ),

          /*GButton(
            icon: Icons.settings,
            text: "Settings",
          ),*/
        ],
      ),
    );
  }
}
