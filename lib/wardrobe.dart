import 'package:emps1/photo_source.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:emps1/wardrobe_top.dart';
import 'package:emps1/wardrobe_bottom.dart';
import 'package:emps1/wardrobe_dress.dart';
import 'package:emps1/wardrobe_footwear.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emps1/generative.dart';
import 'dart:io';
// import 'package:emps/bottom_navigation_bar.dart' as bar;

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  Map<int, List<File>> sectionImages = {}; // 🔹 Stores images for each section

  void addImage(int section, File image) {
    setState(() {
      if (!sectionImages.containsKey(section)) {
        sectionImages[section] = [];
      }
      sectionImages[section]!.add(image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          toolbarHeight: 60,
          backgroundColor: const Color(0xFFC1DB3C),
          bottom: TabBar(
            labelColor: Color(0xE6CC4385),
            labelStyle: GoogleFonts.jacquesFrancois(fontSize: 16, color: Colors.black),
            unselectedLabelStyle: GoogleFonts.jacquesFrancois(fontSize: 16, color: Colors.black),
            dividerColor: Colors.transparent,
            indicatorColor: Color(0xE6CC4385),
            tabs: const [
              Tab(text: 'TOP'),
              Tab(text: 'BOTTOM'),
              Tab(text: 'DRESS'),
              Tab(text: 'FOOTWEAR')
            ],
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      TopPage(sectionImages: sectionImages, onImageAdded: addImage),
                      BottomPage(sectionImages: sectionImages, onImageAdded: addImage),
                      DressPage(sectionImages: sectionImages, onImageAdded: addImage),
                      FootwearPage(sectionImages: sectionImages, onImageAdded: addImage),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20, // Above the bottom navigation bar
              right: 25,  // Right side of the screen
              child: AddClothesButton(onImageAdded: addImage),
            ),
          ],
        ),
        // bottomNavigationBar: const bar.BottomNavigationBar(),
      ),
    );
  }
}

class AddClothesButton extends StatefulWidget {
  final Function(int, File) onImageAdded; // ✅ Function to add image

  const AddClothesButton({super.key, required this.onImageAdded});

  @override
  State<AddClothesButton> createState() => _AddClothesButtonState();
}

class _AddClothesButtonState extends State<AddClothesButton> {
  double _padding = 6;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      // ✅ Ask user which section to add the image to
      int? selectedSection = await _showSectionPicker();

      if (selectedSection != null) {
        widget.onImageAdded(selectedSection, image); // ✅ Add image to section
      }
    }
  }

  Future<void> _showImageSourcePicker() async {
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

  Future<int?> _showSectionPicker() async {
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Section"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(6, (index) {
              return ListTile(
                title: Text('Section ${index + 1}'),
                onTap: () {
                  Navigator.of(context).pop(index); // Return selected section index
                },
              );
            }),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _padding = 0;
        });
      },
      onTapUp: (details) {
        setState(() {
          _padding = 6;
        });
        _showImageSourcePicker(); // ✅ Ask user to choose image source
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.only(bottom: _padding),
        decoration: BoxDecoration(
          color: const Color(0xE6CC4385),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFC1DB3C),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'ADD CLOTHES',
            style: GoogleFonts.jacquesFrancois(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class ShowWardrobeImages extends StatelessWidget {
  final Map<int, List<File>> sectionImages; // Receive images
  final List<String> tabNames; //get tab names dynamically

  const ShowWardrobeImages({super.key, required this.sectionImages, required this.tabNames});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(tabNames.length, (sectionIndex) {
          //don't show section with no images
          if (sectionImages[sectionIndex] == null || sectionImages[sectionIndex]!.isEmpty) {
            return const SizedBox(); // Return an empty widget
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  tabNames[sectionIndex], //tabNames for section titles
                  style: GoogleFonts.jacquesFrancois(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.black),
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: sectionImages[sectionIndex]!.map((imageFile) {
                  return Container(
                    width: 120,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.file(
                      imageFile, // Load stored image
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class WardrobeCategories extends StatefulWidget {
  final double borderRadius;
  final List<String> tabNames;

  const WardrobeCategories({
    super.key,
    this.borderRadius = 30,
    required this.tabNames,
  });

  @override
  State<WardrobeCategories> createState() =>
      _AnimatedRoundedTabbarFilledState();
}

class _AnimatedRoundedTabbarFilledState
    extends State<WardrobeCategories> {
  late List<bool> isHoverList;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    isHoverList = List.generate(widget.tabNames.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.tabNames.length; i += 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                (widget.tabNames.length - i) >= 3 ? 3 : widget.tabNames.length - i,
                    (index) => buildTab(i + index),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildTab(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      onHover: (value) {
        setState(() {
          isHoverList[index] = value;
        });
      },
      child: AnimatedContainer(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: _currentIndex == index || isHoverList[index]
              ? const Color(0xFFEDF9B1)
              : null,
        ),
        child: Text(
          widget.tabNames[index], // Dynamic text
          style: GoogleFonts.jacquesFrancois(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}

