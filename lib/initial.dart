import 'package:emps1/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  InitialScreenState createState() => InitialScreenState();
}

class InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to HomeScreen after 3 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //screen dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFCC4385),
      body: Stack(
        children: [
          // "Style" text with shadow effect
          Positioned(
            top: screenHeight/2 - 100, // Position from the top
            left: 90, // Position from the left
            child: Stack(
              children: [
                // Border effect
                Text(
                  'Style',
                  style: GoogleFonts.homemadeApple(
                    fontSize: 64,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Color(0xFFEDF9B1), // Border color
                  ),
                ),
                // Main text
                Text(
                  'Style',
                  style: GoogleFonts.homemadeApple(
                    fontSize: 64,
                    color: Color(0xFFC1DB3C), // Main text color
                  ),
                ),
              ],
            ),
          ),

          // "Vision" text with shadow effect
          Positioned(
            top: screenHeight/2, // Adjusted based on Figma (relative to "Style")
            right: 85,
            child: Stack(
              children: [
                // Border effect
                Text(
                  'Vision',
                  style: GoogleFonts.homemadeApple(
                    fontSize: 64,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Color(0xFFEDF9B1), // Border color
                  ),
                ),
                // Main text
                Text(
                  'Vision',
                  style: GoogleFonts.homemadeApple(
                    fontSize: 64,
                    color: Color(0xFFC1DB3C), // Main text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}