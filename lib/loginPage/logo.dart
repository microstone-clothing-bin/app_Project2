import 'package:flutter/material.dart';

/// Logo widget that displays the app branding
/// Contains two text elements stacked vertically with Korean text "로고" and "Drop It"
class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main logo text in Korean
        Text(
          '로고',
          style: TextStyle(
            fontSize: 32, // Large text size for prominence
            fontWeight: FontWeight.w800, // Extra bold weight for impact
            color: Color(0xFF7C3AED), // Violet-800 brand color
          ),
        ),
        // Small spacing between logo elements
        SizedBox(height: 4),
        // App name "Drop It"
        Text(
          'Drop It',
          style: TextStyle(
            fontSize: 32, // Matching size with logo text
            fontWeight: FontWeight.w800, // Consistent bold styling
            color: Color(0xFF7C3AED), // Same violet brand color
          ),
        ),
      ],
    );
  }
}
