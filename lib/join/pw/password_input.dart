import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final String value;
  final ValueChanged<String> onChanged;
  final bool showPassword;
  final VoidCallback onTogglePassword;

  const PasswordInput({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.value,
    required this.onChanged,
    required this.showPassword,
    required this.onTogglePassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF18181B),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF7C3AED), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  obscureText: !showPassword,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: placeholder,
                    hintStyle: TextStyle(color: Color(0xFFA3A3A3)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  style: TextStyle(color: Color(0xFF18181B)),
                ),
              ),
              SizedBox(width: 40),
              GestureDetector(
                onTap: onTogglePassword,
                child: Container(
                  width: 14,
                  height: 14,
                  child: Image.network(
                    'https://api.builder.io/api/v1/image/assets/TEMP/cf2f8edffa1741c0a776b276ab938ec52f7a2f43?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
