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
  final TextEditingController _passwordController = TextEditingController(); // Declare the controller
  //final String _passwordHint = "Enter old password"; // Define the hint text

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
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
        child: Column(
          children: [
            Center(
              child: Text('Change Password',
                style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 24),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Old Password:',
                    style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 20)
                )
              ),
            ),
            PasswordInput(textEditingController: _passwordController, hintText: "Enter old password"),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('New Password:',
                      style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 20)
                  )
              ),
            ),
            PasswordInput(textEditingController: _passwordController, hintText: "Enter new password"),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('Confirm New Password:',
                      style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 20)
                  )
              ),
            ),
            PasswordInput(textEditingController: _passwordController, hintText: "Confirm new password"),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFFC1DB3C),
                foregroundColor: Colors.black,
                minimumSize: const Size(100, 60),
                shape: const StadiumBorder(),
              ),
              child: Text("Confirm",
                  style: GoogleFonts.jacquesFrancois(
                      fontSize: 22,
                      color: Colors.black
                  )
              ),
            ),
          ]
        ),
      )
    );
  }
}

class PasswordInput extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;

  const PasswordInput(
      {required this.textEditingController, required this.hintText, super.key});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool pwdVisibility = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: !pwdVisibility,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFEDF9B1),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFEDF9B1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFEDF9B1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        suffixIcon: InkWell(
          onTap: () => setState(
                () => pwdVisibility = !pwdVisibility,
          ),
          child: Icon(
            pwdVisibility
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey.shade400,
            size: 18,
          ),
        ),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}

