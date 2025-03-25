import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenerativeHistoryScreen extends StatelessWidget {
  const GenerativeHistoryScreen({Key? key}) : super(key: key);

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
          // CustomPaint positioned above the background but below other elements
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: Size(screenWidth, 300), // Adjust height to fit within bounds
              painter: ParabolicPainter(),
            ),
          ),
          // Text and buttons positioned above the background and painter
          Positioned(
            top: 110, // Adjust vertical position as needed
            left: 0,  // Use left: 0 to center horizontally with the Stack
            right: 0, // Use right: 0 to center horizontally with the Stack
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
          Positioned(
            top: screenHeight - 600,
            left: (screenWidth - 250) / 2,
            child: CustomButton(text: 'NEW'),
          ),
          Positioned(
            top: screenHeight - 470,
            left: (screenWidth - 250) / 2,
            child: CustomButton(text: 'HISTORY'),
          ),
        ],
      ),
      // bottomNavigationBar: const CustomBottomBar(),
    );

  }
}

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({super.key, required this.text});

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
      onPressed: () {},
      child: Text(
          text,
          style: GoogleFonts.jacquesFrancois(
            fontSize: 25,
            color: Colors.black,
          )
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
      size.width / 2, size.height + 40, // Control point (adjust for curve)
      size.width + 10, size.height - 100, // End point
    );

    path.lineTo(size.width + 10, 0); // Right edge
    path.close(); // Close the shape

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
