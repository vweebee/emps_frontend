import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:emps1/wardrobe.dart';

class BottomPage extends StatelessWidget {
  final Map<int, List<File>> sectionImages;
  final Function(int, File) onImageAdded;

  const BottomPage({super.key, required this.sectionImages, required this.onImageAdded});

  @override
  Widget build(BuildContext context) {
    List<String> tabNames = ['Pants', 'Shorts', 'Skirt'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: WardrobeCategories(tabNames: tabNames),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0), // ✅ Add padding to align with left
            child: TwoDListViewBuilderWidget(sectionImages: sectionImages, tabNames: tabNames,),
          ),
        ),
      ],
    );
  }
}