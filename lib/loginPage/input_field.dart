import 'package:flutter/material.dart';

/// Reusable input field widget with custom styling
/// Supports both regular text input and password input with obscured text
class InputField extends StatelessWidget {
  final String placeholder; // Text to display as placeholder/hint
  final bool isPassword; // Whether to obscure text for password fields

  const InputField({
    Key? key,
    required this.placeholder,
    this.isPassword = false, // Default to regular text input
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Fixed width matching design specifications
      padding: EdgeInsets.all(
        16,
      ), // Internal padding for comfortable touch targets
      decoration: BoxDecoration(
        color: Colors.white, // White background
        border: Border.all(
          color: Color(0xFF7C3AED), // Violet-800 border matching brand colors
          width: 1, // Thin border for subtle definition
        ),
        borderRadius: BorderRadius.circular(
          8,
        ), // Rounded corners for modern look
      ),
      child: TextField(
        obscureText: isPassword, // Hide text for password fields
        decoration: InputDecoration(
          hintText: placeholder, // Display placeholder text
          hintStyle: TextStyle(
            fontSize: 12, // Small text size
            fontWeight: FontWeight.w500, // Medium weight for readability
            color: Color(0xFFA3A3A3), // Neutral-400 gray for placeholder
          ),
          border: InputBorder.none, // Remove default TextField border
          contentPadding: EdgeInsets.zero, // Remove default padding
        ),
        style: TextStyle(
          fontSize: 12, // Consistent text size with placeholder
          fontWeight: FontWeight.w500, // Medium weight for user input
          color: Color(0xFFA3A3A3), // Same color as placeholder initially
        ),
      ),
    );
  }
}
