// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  bool showShortDurationText = false;
  bool showLongDurationText = false;
  late Timer shortDurationTimer;
  late Timer longDurationTimer;

  @override
  void initState() {
    super.initState();
    // Start a timer to show "Hello World" after 5 seconds
    shortDurationTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          showShortDurationText = true;
        });
      }
    });
    // Start another timer to show "Welcome World" after 10 seconds
    longDurationTimer = Timer(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          showLongDurationText = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timers to prevent memory leaks
    shortDurationTimer.cancel();
    longDurationTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: width,
      color: Colors.white.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://media.tenor.com/Ochf0TgGuTYAAAAi/food-hungry.gif',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text('Your Patience is Appreciated!'),
            const SizedBox(height: 20),
            if (showShortDurationText) // Show "Hello World" if the flag is true
              Text(
                'Kindly Wait...',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.greenAccent,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
            if (!showShortDurationText) // Show "Loading..." if the flag is false
              const Text('Loading...'),
            if (showLongDurationText) // Show "Welcome World" if the flag is true
              Text(
                'Sorry for the delay! Our servers are busy. Please wait...',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.greenAccent,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
