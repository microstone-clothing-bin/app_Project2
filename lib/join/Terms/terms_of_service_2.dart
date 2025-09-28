import 'package:flutter/material.dart';
import 'terms_header.dart';
import 'terms_content_2.dart';
import 'check_button.dart';
import 'terms_section.dart';

class TermsOfService2 extends StatelessWidget {
  final VoidCallback? onBackClick;
  final VoidCallback? onConfirmClick;

  const TermsOfService2({Key? key, this.onBackClick, this.onConfirmClick})
    : super(key: key);

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
                  title: '개인정보 수집 및 이용 동의서',
                  child: const TermsContent2(),
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
