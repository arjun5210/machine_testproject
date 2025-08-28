import 'package:flutter/material.dart';
import 'package:tisserproject/Add_page/adding_screen_page.dart';
import 'package:tisserproject/Home_page/home_page.dart';
import 'package:tisserproject/Home_page/profile_page.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [ProjectDashboard(), Addingpage(), profilepage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF3338A0),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tasks"),
            BottomNavigationBarItem(icon: Icon(Icons.save), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
