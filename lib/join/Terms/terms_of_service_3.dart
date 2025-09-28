//위치정보 동의서 메인
import 'package:flutter/material.dart';
import 'terms_header.dart';
import 'terms_section.dart';
import 'terms_content_3.dart';
import 'consent_content.dart';
import 'check_button.dart';

class TermsOfService3 extends StatelessWidget {
  const TermsOfService3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleBackClick() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 64,
              right: 32,
              bottom: 36,
              left: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TermsHeader(),
                TermsSection(
                  title: '위치정보 서비스 이용약관',
                  child: const TermsContent3(),
                ),
                TermsSection(
                  title: '위치정보 서비스 이용 동의서',
                  child: const ConsentContent(),
                ),
                SizedBox(height: 50),
                CheckButton(onPressed: _handleBackClick),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
