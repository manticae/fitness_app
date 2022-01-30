import 'package:flutter/material.dart';

import '../screens/contact_screen.dart';
import 'diet_plans_feed_screen.dart';
import 'program_feed_screen.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = <Widget>[
    ProgramFeedScreen(),
    DietPlansFeedScreen(),
    const ContactScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: const Appdrawer(),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.line_weight,
            ),
            label: 'Program',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fastfood_outlined,
            ),
            activeIcon: Icon(
              Icons.fastfood,
            ),
            label: 'Kost',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.messenger_outline,
            ),
            activeIcon: Icon(
              Icons.messenger_rounded,
            ),
            label: 'kontakt',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
