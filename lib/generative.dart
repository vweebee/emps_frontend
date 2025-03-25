import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emps1/generative_new.dart';
import 'package:emps1/generative_looks.dart';

class GenerativeScreen extends StatefulWidget {
  const GenerativeScreen({super.key});

  @override
  State<GenerativeScreen> createState() => _GenerativeScreenState();
}

class _GenerativeScreenState extends State<GenerativeScreen> {
  int _currentIndex = 0;

  // Create instances once to preserve their state
  final List<Widget> _screens = [
    const GenerativeHome(),
    const GenerativeNewScreen(),
    const GenerativeHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background should be at the bottom of the stack
          Positioned.fill(
            child: Container(color: Colors.white), // Ensure a background color
          ),

          // IndexedStack to manage the screens
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // Only show the parabolic painter and title on the home screen
          if (_currentIndex == 0) ...[
            // CustomPaint positioned above the background
            Positioned(
              top: 0,
              left: 0,
              child: CustomPaint(
                size: Size(screenWidth, 300),
                painter: ParabolicPainter(),
              ),
            ),

            // Text positioned above the painter
            Positioned(
              top: 110,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'GENERATE\nYOUR OUTFIT',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.jacquesFrancois(
                    fontSize: 35,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // NEW button
            Positioned(
              top: screenHeight - 600,
              left: (screenWidth - 250) / 2,
              child: CustomButton(
                text: 'NEW',
                onPressed: () {
                  setState(() {
                    _currentIndex = 1; // Switch to NEW screen
                  });
                },
              ),
            ),

            // HISTORY button
            Positioned(
              top: screenHeight - 470,
              left: (screenWidth - 250) / 2,
              child: CustomButton(
                text: 'LOOKS',
                onPressed: () {
                  setState(() {
                    _currentIndex = 2; // Switch to HISTORY screen
                  });
                },
              ),
            ),
          ],

          // Back button for NEW and HISTORY screens
          if (_currentIndex != 0)
            Positioned(
              top: 67,
              left: 5,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 50),
                color: const Color(0xFFCC4385),
                onPressed: () {
                  setState(() {
                    _currentIndex = 0; // Return to home screen
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}

// Add this new widget for the home screen
class GenerativeHome extends StatelessWidget {
  const GenerativeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(); // Empty container as the content is managed by the parent
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC1DB3C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90),
        ),
        minimumSize: Size(250, 100),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.jacquesFrancois(
          fontSize: 25,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ParabolicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xE6CC4385);

    Path path = Path();
    path.moveTo(-10, 0); // Start at top-left
    path.lineTo(-10, size.height - 100); // Left edge

    // Parabolic curve
    path.quadraticBezierTo(
      size.width / 2, size.height + 40, // Control point
      size.width + 10, size.height - 100, // End point
    );

    path.lineTo(size.width + 10, 0); // Right edge
    path.close(); // Close the shape

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}