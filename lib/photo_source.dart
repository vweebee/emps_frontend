import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//GA DIPAKE

class StarterView extends StatelessWidget {
  const StarterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC1DB3C),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'CONFIRM YOUR ITEM',
                        style: GoogleFonts.jacquesFrancois(fontSize: 24, color: Colors.black),
                      ),
                      const SizedBox(height: 10), // Space between text and rectangle
                      Container(
                        height: 550,
                        width: 375,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30), // Rounded rectangle
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // const Spacer(),
            const SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Add this item to your wardrobe?',
                style: GoogleFonts.jacquesFrancois(fontSize: 24, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFFEDF9B1),
                foregroundColor: Colors.black,
                minimumSize: const Size(300, 52),
                shape: const StadiumBorder(),
              ),
              child: Text("Yes",
                  style: GoogleFonts.jacquesFrancois(
                      fontSize: 24,
                      color: Colors.black
                  )
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFFEDF9B1),
                foregroundColor: Colors.black,
                minimumSize: const Size(300, 52),
                shape: const StadiumBorder(),
              ),
              child: Text("Use another picture",
                  style: GoogleFonts.jacquesFrancois(
                      fontSize: 24,
                      color: Colors.black
                  )
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFFEDF9B1),
                foregroundColor: Colors.black,
                minimumSize: const Size(300, 52),
                shape: const StadiumBorder(),
              ),
              child: Text("Cancel",
                  style: GoogleFonts.jacquesFrancois(
                      fontSize: 24,
                      color: Colors.black
                  )
              ),
            ),
            // Padding(
            //
            //   // padding: const EdgeInsets.symmetric(horizontal: 24),
            //   // child: CustomBouncingButton(
            //   //   onTap: () {},
            //   //   text: 'Get Started',
            //   // ),
            // ),
          ],
        ),
      ),
    );
  }
}


class CustomBouncingButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const CustomBouncingButton(
      {super.key, required this.text, required this.onTap});

  @override
  State<CustomBouncingButton> createState() => _CustomBouncingButtonState();
}

class _CustomBouncingButtonState extends State<CustomBouncingButton>
    with SingleTickerProviderStateMixin {
  double _scale = 0;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
        onTapDown: _tapDown,
        onTapUp: _tapUp,
        onTap: widget.onTap,
        child: Transform.scale(
            scale: _scale,
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Colors.blue,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x80000000),
                    blurRadius: 12.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )));
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}

class CustomAnimatedText extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final int seconds;
  const CustomAnimatedText(
      {super.key,
        required this.seconds,
        required this.text,
        required this.fontSize,
        required this.fontWeight,
        required this.fontColor});

  @override
  State<CustomAnimatedText> createState() => _CustomAnimatedTextState();
}

class _CustomAnimatedTextState extends State<CustomAnimatedText> {
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    changeOpacity();
  }

  changeOpacity() {
    Future.delayed(Duration(seconds: widget.seconds), () {
      setState(() {
        opacity = opacity == 0.0 ? 1.0 : 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: opacity == 1 ? 0 : 1,
        duration: const Duration(seconds: 1),
        child: Text(
          widget.text,
          style: TextStyle(
              color: widget.fontColor,
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight),
        ));
  }
}