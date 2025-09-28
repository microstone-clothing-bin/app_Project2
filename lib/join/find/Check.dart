import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/loginPage/loginMainPage.dart';

class CheckStep extends StatefulWidget {
  const CheckStep({Key? key}) : super(key: key);

  @override
  State<CheckStep> createState() => _CheckStep();
}

class _CheckStep extends State<CheckStep> {
  void _handleNextClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TokenCheck()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        margin: const EdgeInsets.symmetric(horizontal: 32),
        padding: const EdgeInsets.only(top: 208, bottom: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.33,
                  color: Color.fromRGBO(24, 24, 27, 1),
                ),
                children: [
                  TextSpan(
                    text: "nickname",
                    style: const TextStyle(
                      color: Color.fromRGBO(96, 41, 183, 1),
                    ),
                  ),
                  const TextSpan(text: ' 님,\n비밀번호 변경이 완료되었습니다.'),
                ],
              ),
            ),

            Expanded(child: Container()),

            // Next button
            Positioned(
              bottom: 62,
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
                    '로그인하러가기',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
