import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/join/progress_indicator.dart' as custom;
import 'package:microstone_clothing_bin/join/signup_header.dart';
import 'nickname_form.dart';

class NicknameMain extends StatefulWidget {
  const NicknameMain({super.key});

  @override
  State<NicknameMain> createState() => _NicknameMain();
}

class _NicknameMain extends State<NicknameMain> {
  void _handleNext() {
    // Handle navigation to next step
    print('Proceeding to next step');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 480),
          margin: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 64,
                      left: 12,
                      right: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        SignupHeader(),
                        //const HadJoinForm(),
                        Center(
                          child: custom.ProgressIndicator(
                            currentStep: 4,
                            totalSteps: 5,
                          ),
                        ),
                        NicknameForm(onNext: _handleNext),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
