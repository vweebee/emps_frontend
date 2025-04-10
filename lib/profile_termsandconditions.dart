import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsScreen extends StatefulWidget {

  const TermsAndConditionsScreen({super.key});

  @override
  TermsAndConditionsScreenState createState() => TermsAndConditionsScreenState();
}

class TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Stack(
            children: [
              Container(
                color: const Color(0xFFC1DB3C),
                height: 180,
              ),
              Center(
                child: Text('TERMS & CONDITIONS',
                    style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 24))
              ),
              Positioned(
                top: 80,
                left: 5,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, size: 50),
                  color: Color(0xFFCC4385), // Changed to white for visibility on green background
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView()
    );
  }
}
