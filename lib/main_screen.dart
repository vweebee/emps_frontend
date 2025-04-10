import 'package:emps1/generative_looks.dart';
import 'package:emps1/generative_new.dart';
import 'package:emps1/profile.dart';
import 'package:flutter/material.dart';
import 'package:emps1/generative.dart';
import 'package:emps1/wardrobe.dart';
import 'package:emps1/CustomBottomBar.dart'; // Import the custom bottom bar

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const WardrobeScreen(),   // Wardrobe
    const GenerativeScreen(), // Generate
    const ProfileScreen(), // Profile placeholder
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Matches the app background
      body: _pages[_selectedIndex], // This is where the body content changes
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(30), // Make sure the radius matches your bottom bar
        ),
        child: CustomBottomBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
