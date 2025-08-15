import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/join/consent_join.dart';

class FooterLinks extends StatelessWidget {
  const FooterLinks({Key? key}) : super(key: key);

  /// Handles sign up link tap - navigates to registration screen

  /// Handles find ID link tap - navigates to ID recovery screen
  void _handleFindId() {
    // TODO: Navigate to ID recovery screen
    print('Find ID clicked');
  }

  /// Handles find password link tap - navigates to password recovery screen
  void _handleFindPassword() {
    // TODO: Navigate to password recovery screen
    print('Find password clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Fixed width matching other form elements
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Distribute links evenly
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JoinForm()),
              );
              //JoinForm
            },
            child: Text(
              '회원가입', // Korean for "Sign up"
              style: TextStyle(
                fontSize: 12, // Small text size for secondary actions
                color: Color(0xFF18181B), // Zinc-900 dark gray for readability
              ),
            ),
          ),
          // Find ID link
          GestureDetector(
            onTap: _handleFindId,
            child: Text(
              '아이디 찾기', // Korean for "Find ID"
              style: TextStyle(
                fontSize: 12, // Consistent text size
                color: Color(0xFF18181B), // Same dark gray color
              ),
            ),
          ),
          // Find password link
          GestureDetector(
            onTap: _handleFindPassword,
            child: Text(
              '비밀번호 찾기', // Korean for "Find Password"
              style: TextStyle(
                fontSize: 12, // Consistent text size
                color: Color(0xFF18181B), // Same dark gray color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
