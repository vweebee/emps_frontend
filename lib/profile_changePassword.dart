import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ChangePasswordScreen extends StatefulWidget {
  final File? profileImage;

  const ChangePasswordScreen({super.key, this.profileImage});

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.pink,
                backgroundImage: widget.profileImage != null ? FileImage(widget.profileImage!) : null,
                child: widget.profileImage == null
                    ? const Icon(Icons.person, color: Colors.white, size: 40)
                    : null,
              ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Change Password',
              style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 24),
            )
          ]
        ),
      )
    );
  }
}
