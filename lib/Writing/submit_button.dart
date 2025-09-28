import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onClick;
  final bool disabled;

  const SubmitButton({Key? key, this.onClick, this.disabled = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, left: 12),
      child: ElevatedButton(
        onPressed: disabled ? null : onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF7C3AED),
          disabledBackgroundColor: const Color(0xFF7C3AED).withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          '등록',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
