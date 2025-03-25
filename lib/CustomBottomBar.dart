import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      height: 70,
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.circle,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 12),  // Increase vertical padding to make it taller
      snakeViewColor: const Color(0xE6CC4385),
      selectedItemColor: selectedIndex == 1 ? const Color.fromARGB(230, 255, 255, 255) : null,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.checkroom, size: 40), label: 'Wardrobe'),  // Increase icon size
        BottomNavigationBarItem(icon: Icon(Icons.accessibility_new, size: 40), label: 'Generate'),
        BottomNavigationBarItem(icon: Icon(Icons.person, size: 40), label: 'Profile'),
      ],
      selectedLabelStyle: const TextStyle(fontSize: 14),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      backgroundColor: const Color(0xFFC1DB3C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30)
        ),
      ),
    );
  }
}
