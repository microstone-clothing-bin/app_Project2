import 'package:flutter/material.dart';

class HadJoinForm extends StatelessWidget {
  const HadJoinForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 500;
    final isMobile = screenWidth <= 390;

    final containerWidth = isMobile ? screenWidth : (isTablet ? 500.0 : 390.0);
    final containerHeight = screenHeight < 844 ? screenHeight : 844.0;

    void _handleBackClick() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: containerWidth,
          height: containerHeight,
          color: Colors.white,
          child: Stack(
            children: [
              // Header with back button and title
              Positioned(
                top: 66,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    // Back button
                    Positioned(
                      left: 11,
                      child: GestureDetector(
                        onTap: _handleBackClick,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Transform.rotate(
                            angle: 1.5708, // 90 degrees in radians
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                              color: Color(0xFF6029B7),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Title
                    Center(
                      child: Container(
                        height: 21,
                        alignment: Alignment.center,
                        child: const Text(
                          '회원가입',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF6029B7),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
