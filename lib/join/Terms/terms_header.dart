//이용약관해더
import 'package:flutter/material.dart';

class TermsHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const TermsHeader({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleBackClick() {
      Navigator.of(context).pop();
    }

    return Container(
      width: 216,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '이용약관',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF7C3AED),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
