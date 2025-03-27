import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emps1/CustomBottomBar.dart';
import 'package:emps1/wardrobe.dart';
// import 'package:flutter_gl/flutter_gl.dart';

class GenerativeNewScreen extends StatefulWidget {
  final Function(bool)? onOutfitViewChanged;

  const GenerativeNewScreen({
    super.key,
    this.onOutfitViewChanged,
  });

  @override
  State<GenerativeNewScreen> createState() => _GenerativeNewScreenState();
}

class _GenerativeNewScreenState extends State<GenerativeNewScreen> {
  bool _showOutfitView = false;
  String _selectedStyle = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: IndexedStack(
        index: _showOutfitView ? 1 : 0,
        children: [
          // Style Selection View (index 0)
          buildStyleSelectionView(screenHeight, screenWidth),

          // Outfit View (index 1)
          buildOutfitView(screenWidth),
        ],
      ),
    );
  }

  // Override setState to notify parent when outfit view changes
  @override
  void setState(VoidCallback fn) {
    final bool oldShowOutfitView = _showOutfitView;
    super.setState(fn);

    // Check if _showOutfitView changed and notify parent if it did
    if (oldShowOutfitView != _showOutfitView && widget.onOutfitViewChanged != null) {
      widget.onOutfitViewChanged!(_showOutfitView);
    }
  }

  // Style Selection View
  Widget buildStyleSelectionView(double screenHeight, double screenWidth) {
    return Stack(
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
        // Text positioned above the painter
        Positioned(
          top: 80, // Adjust vertical position as needed
          left: 0,  // Use left: 0 to center horizontally with the Stack
          right: 0, // Use right: 0 to center horizontally with the Stack
          child: Center(
            child: Text(
              'PICK A STYLE',
              textAlign: TextAlign.center,
              style: GoogleFonts.jacquesFrancois(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
        ),
        // Style buttons
        Positioned(
          top: screenHeight - 820,
          left: (screenWidth - 400) / 2,
          child: StyleButton(
            text: 'FORMAL',
            onPressed: () {
              setState(() {
                _selectedStyle = 'FORMAL';
                _showOutfitView = true;
              });
            },
          ),
        ),
        Positioned(
          top: screenHeight - 700,
          left: (screenWidth - 400) / 2,
          child: StyleButton(
            text: 'SEMIFORMAL',
            onPressed: () {
              setState(() {
                _selectedStyle = 'SEMIFORMAL';
                _showOutfitView = true;
              });
            },
          ),
        ),
        Positioned(
          top: screenHeight - 580,
          left: (screenWidth - 400) / 2,
          child: StyleButton(
            text: 'CASUAL',
            onPressed: () {
              setState(() {
                _selectedStyle = 'CASUAL';
                _showOutfitView = true;
              });
            },
          ),
        ),
        Positioned(
          top: screenHeight - 460,
          left: (screenWidth - 400) / 2,
          child: StyleButton(
            text: 'BOHEMIAN',
            onPressed: () {
              setState(() {
                _selectedStyle = 'BOHEMIAN';
                _showOutfitView = true;
              });
            },
          ),
        ),
        Positioned(
          top: screenHeight - 340,
          left: (screenWidth - 400) / 2,
          child: StyleButton(
            text: 'STREETWEAR',
            onPressed: () {
              setState(() {
                _selectedStyle = 'STREETWEAR';
                _showOutfitView = true;
              });
            },
          ),
        ),
        Positioned(
          top: screenHeight - 220,
          left: (screenWidth - 400) / 2,
          child: StyleButton(
            text: 'SPORTY',
            onPressed: () {
              setState(() {
                _selectedStyle = 'SPORTY';
                _showOutfitView = true;
              });
            },
          ),
        ),
      ],
    );
  }

  // Outfit View
  Widget buildOutfitView(double screenWidth) {
    return Stack(
      children: [
        // White background
        Positioned.fill(
          child: Container(color: Colors.white),
        ),

        // Parabolic painter for header
        Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: Size(screenWidth, 300),
              painter: ParabolicPainter(),
            )
        ),

        // Back button
        Positioned(
          top: 67,
          left: 5,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 50),
            color: Color(0xFFCC4385), // Changed to white for visibility on green background
            onPressed: () {
              setState(() {
                _showOutfitView = false; // Return to style selection
              });
            },
          ),
        ),

        // Style name
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              _selectedStyle,
              textAlign: TextAlign.center,
              style: GoogleFonts.jacquesFrancois(
                fontSize: 30,
                color: Colors.black, // Changed to white for visibility
              ),
            ),
          ),
        ),

        // Mannequin and outfit items
        Positioned(
          top: 180, // Adjusted to be below the parabolic header
          left: 0,
          right: 0,
          bottom: 70,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Mannequin image
                // Container(
                //   height: 300,
                //   width: screenWidth,
                //   alignment: Alignment.center,
                //   child: ModelViewerSection(
                //     modelPath: 'assets/kawashaki_ninja_h2.glb',
                //   ),
                // ),

                // Outfit item placeholders
                ...List.generate(4, (index) =>
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        border: index == 2 ? Border.all(color: Colors.blue, width: 3) : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    )
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class StyleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const StyleButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffedf9b1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90),
        ),
        minimumSize: const Size(400, 80),
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
    Paint paint = Paint()..color = const Color(0xFFC1DB3C);

    Path path = Path();
    path.moveTo(-10, 0); // Start at top-left
    path.lineTo(-10, size.height - 150); // Left edge

    // Parabolic curve
    path.quadraticBezierTo(
      size.width / 2, size.height - 150, // Control point (adjust for curve)
      size.width + 10, size.height - 150, // End point
    );

    path.lineTo(size.width + 10, 0); // Right edge
    path.close(); // Close the shape

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// class ModelViewerSection extends StatelessWidget {
//   final String modelPath;

//   const ModelViewerSection({
//     Key? key,
//     required this.modelPath,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ModelViewer(
//       src: modelPath, // Use asset path
//       alt: "A 3D mannequin model",
//       ar: true,
//       autoRotate: false,
//       cameraControls: false,
//     );
//   }
// }