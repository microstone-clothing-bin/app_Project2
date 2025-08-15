import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/join/next_button.dart';
import 'join_Finish.dart';

class NicknameForm extends StatefulWidget {
  final VoidCallback onNext;

  const NicknameForm({Key? key, required this.onNext}) : super(key: key);

  @override
  State<NicknameForm> createState() => _NicknameFormState();
}

class _NicknameFormState extends State<NicknameForm> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _handleNextClick() {
    final nickname = _nicknameController.text.trim();
    if (_nicknameController.text.trim().isEmpty) {
      print("닉네임이 비어있습니다.");
    } else {
      print("닉네임: ${_nicknameController.text}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => join_Finish(nickname: nickname),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 64, left: 20),
          child: const Text(
            '닉네임을 입력해주세요.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF18181B), // zinc-900
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48, left: 20),
          child: const Text(
            '닉네임',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF18181B), // zinc-900
            ),
          ),
        ),
        Container(
          width: 330,
          margin: const EdgeInsets.only(top: 8, left: 25),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFF7C3AED), // violet-800
              width: 1,
            ),
          ),
          child: TextField(
            controller: _nicknameController,
            decoration: const InputDecoration(
              hintText: '닉네임 입력',
              hintStyle: TextStyle(
                color: Color(0xFFA3A3A3), // neutral-400
                fontWeight: FontWeight.w500,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),

        SizedBox(height: 200),

        NextButton(onPressed: _handleNextClick),
      ],
    );
  }
}
