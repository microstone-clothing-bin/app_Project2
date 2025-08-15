import 'package:flutter/material.dart';
import 'nickname_form.dart';
import 'package:microstone_clothing_bin/loginPage/loginMainPage.dart';

class join_Finish extends StatefulWidget {
  final String nickname;
  final VoidCallback? onReturnToLogin;

  const join_Finish({
    Key? key,
    this.nickname = 'user nickname1',
    this.onReturnToLogin,
  }) : super(key: key);

  @override
  State<join_Finish> createState() => _RegistrationSuccess();
}

class _RegistrationSuccess extends State<join_Finish> {
  @override
  void _handlePress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TokenCheck()),
    );
  }

  void _handleNextClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TokenCheck()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 500;
    final isMobile = screenWidth <= 390;

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
                  const TextSpan(text: ' 님,\n회원가입을 축하합니다.'),
                ],
              ),
            ),

            Expanded(child: Container()),

            // Next button
            Positioned(
              bottom: 62,
              left: isMobile
                  ? screenWidth * 0.08
                  : (isTablet ? screenWidth * 0.06 : 30),
              right: isMobile
                  ? screenWidth * 0.08
                  : (isTablet ? screenWidth * 0.06 : 30),
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
