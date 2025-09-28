import 'package:flutter/material.dart';

class FormTextarea extends StatelessWidget {
  final String label;
  final String placeholder;
  final String? value;
  final Function(String)? onChange;

  const FormTextarea({
    Key? key,
    required this.label,
    required this.placeholder,
    this.value,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 24, left: 12),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF18181B),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8, left: 12),
          width: 330,
          child: TextField(
            controller: TextEditingController(text: value),
            onChanged: onChange,
            maxLines: 8,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFA3A3A3),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 144),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFFD4D4D8),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFFD4D4D8),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Color(0xFF7C3AED),
                  width: 2,
                ),
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFFA3A3A3),
            ),
          ),
        ),
      ],
    );
  }
}
