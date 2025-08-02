import 'package:flutter/material.dart';
import 'package:ikotech/src/screens/home_screen_b2b.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreenB2b(),
    Center(child: Text('My Trips Page')),
    Center(child: Text('Offers Page')),
    Center(child: Text('Contact Us Page')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'My Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.percent), label: 'Offer'),
          BottomNavigationBarItem(
            icon: Icon(Icons.support_agent),
            label: 'Contact us',
          ),
        ],
      ),
    );
  }
}
