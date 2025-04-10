import 'dart:math';
import 'dart:io';
import 'package:emps1/profile_changePassword.dart';
import 'package:emps1/profile_termsandconditions.dart';
import 'package:emps1/sign_in.dart';
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
  OverlayEntry? _overlayEntry;

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

  //overlay function
  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 450,
        left: 50,
        right: 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFC1DB3C),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 5))
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Log out?',
                  style: GoogleFonts.jacquesFrancois(fontSize: 24, color: Colors.black),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFCC4385),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(48, 52),
                        shape: const StadiumBorder(),
                      ),
                      child: Text("Cancel", style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 20)),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;

                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()
                            )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFEDF9B1),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(48, 52),
                        shape: const StadiumBorder(),
                      ),
                      child: Text("Log Out", style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 20)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
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
              left: 182, // Positioned right of profile picture
              child: Row(
                children: [
                  SizedBox(
                    width: 160, // Fixed width for consistency
                    child: TextField(
                      controller: _usernameController,
                      readOnly: _isReadOnly, // Controlled Read-Only State
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.black54),
                      ),
                      style: GoogleFonts.jacquesFrancois(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
                  SizedBox(width: 10),
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 55),
        child: Column(
          children: [
            MembershipCard(),
            SizedBox(height: 50),
            const Divider(
              height: 5, // Space above and below the divider
              thickness: 2, // Divider thickness (makes it bold)
              color: Colors.black45, // Change color if needed
            ),
            Form(
              child: Column(
                children: [
                  SizedBox(height: 35),
                  Text('Account Information',
                    style: GoogleFonts.jacquesFrancois(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 45,
                    width: 250,
                    // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF9B1), // dark color similar to the image
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text('EMPS@gmail.com',
                        style: GoogleFonts.jacquesFrancois(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen(profileImage: _profileImage),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFFEDF9B1),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(250, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text("Change Password",
                        style: GoogleFonts.jacquesFrancois(
                            fontSize: 20,
                            color: Colors.black
                        )
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35),
            const Divider(
              height: 35, // Space above and below the divider
              thickness: 2, // Divider thickness (makes it bold)
              color: Colors.black45, // Change color if needed
            ),

            Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.file_copy, size: 80, color: Colors.black54),
                SizedBox(width: 10),
                Text("Terms & Conditions", style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 24)),
                IconButton(
                  icon: Icon(Icons.chevron_right, size: 60, color: Colors.black54),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => TermsAndConditionsScreen()
                        )
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            const Divider(
              height: 35, // Space above and below the divider
              thickness: 2, // Divider thickness (makes it bold)
              color: Colors.black45, // Change color if needed
            ),
            Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.logout, size: 80, color: Colors.black54),
                SizedBox(width: 10),
                Text("Log Out", style: GoogleFonts.jacquesFrancois(color: Colors.black, fontSize: 24)),
                SizedBox(width: 134),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_right, size: 60 ,color: Colors.black54),
                      onPressed: () {
                        _showOverlay();
                      },
                    ),
                  ],
                ),
              ],
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
                '  0',
                style: GoogleFonts.jacquesFrancois(
                  color: Colors.black,
                  fontSize: 27.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '0   ',
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

