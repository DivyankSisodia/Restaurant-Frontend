// ignore_for_file: library_private_types_in_public_api, file_names

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTextSearchBar extends StatefulWidget {
  const AnimatedTextSearchBar({super.key});

  @override
  _AnimatedTextSearchBarState createState() => _AnimatedTextSearchBarState();
}

class _AnimatedTextSearchBarState extends State<AnimatedTextSearchBar> {
  final List<String> _foods = [
    'pizza',
    'milk',
    'bread',
    'apple',
    'chicken',
    'pasta',
    'ice cream',
  ];

  int _foodIndex = 0;
  String get _searchHintText => 'Search for "${_foods[_foodIndex]}"';

  Timer? _timer;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _foodIndex = (_foodIndex + 1) % _foods.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      decoration: InputDecoration(
        fillColor: Colors.grey[100],
        filled: true,
        hintText: _searchHintText,
        contentPadding: const EdgeInsets.only(left: 26.0),
        hintStyle: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.poppins().fontFamily,
          color: Colors.grey[700],
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            width: 2,
            color: Colors.blueGrey,
          ),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                // Handle search icon press
              },
              icon: Icon(
                CupertinoIcons.search,
                color: Colors.grey[800],
              ),
            ),
            Container(
              height: 20,
              width: 2,
              color: Colors.grey[400],
            ),
            IconButton(
              onPressed: () {
                // Handle mic icon press
              },
              icon: const Icon(
                CupertinoIcons.mic_solid,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
