// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showBlur = true;

  @override
  void initState() {
    super.initState();
    // Start the timer to remove the blur effect after 4 seconds
    Timer(const Duration(seconds: 4), () {
      setState(() {
        _showBlur = false;
      });
    });
    Timer(const Duration(seconds: 8), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: _showBlur ? 2 : 0, sigmaY: _showBlur ? 2 : 0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color(0xFFC5DDFF), // Background color
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBlurredImage("images/logo.png", 380, 370),
                _buildBlurredImage("images/map.png", 260, double.infinity),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF0C264D)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlurredImage(String imagePath, double height, double width) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Original image
        Image.asset(
          imagePath,
          height: height,
          width: width,
        ),
        // Blur effect on top of the image if _showBlur is true
        if (_showBlur)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              color: Colors.transparent, // Transparent color
              height: height,
              width: width,
            ),
          ),
      ],
    );
  }
}
