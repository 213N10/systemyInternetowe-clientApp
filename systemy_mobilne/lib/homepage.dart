import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:systemy_mobilne/classes/user.dart';
import 'pages/profile.dart';

class Homepage extends StatefulWidget{
  final User user;
  final String token;
  const Homepage({super.key, required this.user, required this.token});

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
    const Center(child: Text('Home Page')),
    const Center(child: Text('Questions Page')),
    Profile(user: widget.user),
    const Center(child: Text('Settings Page')),
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

          GButton(
            icon: Icons.settings,
            text: "Settings",
          ),
        ],
      ),
    );
  }
}
