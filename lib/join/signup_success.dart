import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/loginPage/loginMainPage.dart';

class SignupSuccessPage extends StatelessWidget {
  final String nickname;

  const SignupSuccessPage({Key? key, required this.nickname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  children: [
                    TextSpan(
                      text: nickname,
                      style: const TextStyle(
                        color: Color.fromRGBO(96, 41, 183, 1), // 보라색
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: ' 님,\n회원가입을 축하합니다.'),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginMainPage()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7), // 보라색 버튼
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "로그인 화면으로 돌아가기",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
