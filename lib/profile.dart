import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  bool _isReadOnly = true;
  String? _selectedGender;

  // Function to pick an image
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Show options to choose camera or gallery
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Makes the corners smooth
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEDF9B1), // Change this to your desired background color
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Colors.black),
                  title: Text(
                    "Take a photo",
                    style: GoogleFonts.jacquesFrancois(fontSize: 18, color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.black),
                  title: Text(
                    "Choose from gallery",
                    style: GoogleFonts.jacquesFrancois(fontSize: 18, color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Generate a random username
  String _generateRandomUsername() {
    List<String> adjectives = ["Cool", "Fast", "Smart", "Happy", "Brave"];
    List<String> nouns = ["Tiger", "Eagle", "Lion", "Cheetah", "Panther"];
    int number = Random().nextInt(1000); // Random number from 0 to 999
    return "${adjectives[Random().nextInt(adjectives.length)]}${nouns[Random().nextInt(nouns.length)]}$number";
  }

  @override
  void initState() {
    super.initState();
    _usernameController.text = _generateRandomUsername(); // ✅ Set random username at startup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180), // Increased height for stacking
        child: Stack(
          children: [
            Container(
              color: const Color(0xFFC1DB3C), // Background color
              height: 180,
            ),

            // ✅ Profile Picture (Positioned on Left)
            Positioned(
              top: 65,
              left: 75, // Adjust left position
              child: GestureDetector(
                onTap: _showImagePickerOptions,
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.pink,
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? Icon(Icons.person, color: Colors.white, size: 40)
                      : null,
                ),
              ),
            ),

            // ✅ Username & Edit Icon (Positioned Next to Profile Picture)
            Positioned(
              top: 70,
              left: 185, // Positioned right of profile picture
              child: Row(
                children: [
                  Text(
                    _usernameController.text,
                    style: GoogleFonts.jacquesFrancois(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    icon: Icon(Icons.edit, size: 18),
                    onPressed: () {
                      setState(() {
                        _isReadOnly = !_isReadOnly;
                      });
                    },
                  ),
                ],
              ),
            ),

            // ✅ Gender Selection (Below Username)
            Positioned(
              top: 105,
              left: 165, // Aligned with username
              child: Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: "Male",
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                        activeColor: Colors.black,
                      ),
                      Text("Male", style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 16)),
                    ],
                  ),
                  SizedBox(width: 15),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Female",
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                        activeColor: Colors.black,
                      ),
                      Text("Female", style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 55),
        child: Column(
          children: [
            MembershipCard(),
            SizedBox(height: 50),
            const Divider(),
            Form(
              child: Column(
                children: [

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF9B1), // dark color similar to the image
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start    ,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ' 12',
                style: GoogleFonts.jacquesFrancois(
                  color: Colors.black,
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '45   ',
                style: GoogleFonts.jacquesFrancois(
                  color: Colors.black,
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Items',
                style: GoogleFonts.jacquesFrancois(
                    color: Colors.black,
                    fontSize: 18.0,),
              ),
              Text(
                'Outfits',
                style: GoogleFonts.jacquesFrancois(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({
    super.key,
    required this.text,
    required this.child,
  });

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(text),
          ),
          Expanded(
            flex: 3,
            child: child,
          ),
        ],
      ),
    );
  }
}
