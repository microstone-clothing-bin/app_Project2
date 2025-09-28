//회원가입 동의서 메인

import 'package:flutter/material.dart';
import 'terms_header.dart';
import 'terms_content_1.dart';
import 'check_button.dart';
import 'terms_section.dart';

class TermsOfService1 extends StatelessWidget {
  final VoidCallback? onBack;

  const TermsOfService1({Key? key, this.onBack}) : super(key: key);

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
                  title: '회원가입 이용약관',
                  child: const TermsContent1()
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
