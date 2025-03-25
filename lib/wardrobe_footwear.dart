import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:emps1/wardrobe.dart';

class FootwearPage extends StatelessWidget {
  final Map<int, List<File>> sectionImages;
  final Function(int, File) onImageAdded;

  const FootwearPage({super.key, required this.sectionImages, required this.onImageAdded});

  @override
  Widget build(BuildContext context) {
    List<String> tabNames = ['Sneakers', 'Shoes', 'Heels', 'Flats'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: WardrobeCategories(tabNames: tabNames),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ShowWardrobeImages(sectionImages: sectionImages, tabNames: tabNames,),
          ),
        ),
      ],
    );
  }
}