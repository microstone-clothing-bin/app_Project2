//사이즈 설정
import 'package:flutter/material.dart';

class TermsSection extends StatelessWidget {
  final String title;
  final Widget child;

  const TermsSection({Key? key, required this.title, required this.child})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32, left: 20),
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF18181B),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
