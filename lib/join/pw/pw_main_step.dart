import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/join/signup_header.dart';
import 'package:microstone_clothing_bin/join/progress_indicator.dart' as custom;
import 'password_input.dart';
import 'validation_requirements.dart';
import 'package:microstone_clothing_bin/join/next_button.dart';
import 'package:microstone_clothing_bin/join/name/Nickname_main.dart';

class PwMainStep extends StatefulWidget {
  const PwMainStep({Key? key}) : super(key: key);

  @override
  State<PwMainStep> createState() => _PwMainStep();
}

class _PwMainStep extends State<PwMainStep> {
  String password = "";
  String confirmPassword = "";
  bool showPassword = false;
  bool showConfirmPassword = false;

  void _handleBackClick() {
    // Handle navigation back
    print("Navigate back");
  }

  void _handleNextClick() {
    // Handle navigation to next step
    print("Navigate to next step");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NicknameMain()),
    );
  }

  bool _isPasswordValid() {
    final hasUpperLower = RegExp(r'[a-zA-Z]').hasMatch(password);
    final hasNumber = RegExp(r'\d').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    final hasValidLength = password.length >= 8 && password.length <= 20;
    final passwordsMatch =
        password == confirmPassword && confirmPassword.isNotEmpty;

    return hasUpperLower &&
        hasNumber &&
        hasSpecial &&
        hasValidLength &&
        passwordsMatch;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        constraints: BoxConstraints(maxWidth: 480),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(12, 64, 32, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SignupHeader(onBackClick: _handleBackClick),

                      Center(
                        child: custom.ProgressIndicator(
                          currentStep: 3,
                          totalSteps: 5,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 64, left: 20),
                        child: Text(
                          '비밀번호를 입력해주세요.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF18181B),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 48, left: 20),
                        width: 400,
                        child: PasswordInput(
                          label: "비밀번호",
                          placeholder: "비밀번호 입력",
                          value: password,
                          onChanged: (value) =>
                              setState(() => password = value),
                          showPassword: showPassword,
                          onTogglePassword: () =>
                              setState(() => showPassword = !showPassword),
                        ),
                      ),

                      Center(child: ValidationRequirements(password: password)),

                      Container(
                        margin: EdgeInsets.only(top: 48, left: 20),
                        width: 400,
                        child: PasswordInput(
                          label: "비밀번호 확인",
                          placeholder: "비밀번호 재입력",
                          value: confirmPassword,
                          onChanged: (value) =>
                              setState(() => confirmPassword = value),
                          showPassword: showConfirmPassword,
                          onTogglePassword: () => setState(
                            () => showConfirmPassword = !showConfirmPassword,
                          ),
                        ),
                      ),

                      SizedBox(height: 200),

                      NextButton(
                        onPressed: _handleNextClick,
                        disabled: !_isPasswordValid(),
                      ),
                    ],
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
