import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/Sharing/sharing_post_form.dart';

class BottomIcon1 extends StatelessWidget {
  const BottomIcon1({super.key});

  @override
  Widget build(BuildContext context) {
    void _handleNextClick() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SharingPostForm()),
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          child: GestureDetector(
            onTap: _handleNextClick,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFF6029B7),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Text(
                '다음으로',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
