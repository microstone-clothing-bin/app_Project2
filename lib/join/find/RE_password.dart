import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/join/progress_indicator.dart' as custom;
import 'package:microstone_clothing_bin/join/pw/password_input.dart';
import 'package:microstone_clothing_bin/join/pw/validation_requirements.dart';
import 'package:microstone_clothing_bin/join/next_button.dart';
import 'Check.dart';

class RePwStep extends StatefulWidget {
  const RePwStep({Key? key}) : super(key: key);

  @override
  State<RePwStep> createState() => _RePwStep();
}

class _RePwStep extends State<RePwStep> {
  String password = "";
  String confirmPassword = "";
  bool showPassword = false;
  bool showConfirmPassword = false;

  void _handleBackClick() {
    // Handle navigation back
    Navigator.of(context).pop();
  }

  void _handleNextClick() {
    // Handle navigation to next step
    print("Navigate to next step");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckStep()),
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
                      Positioned(
                        left: 11,
                        child: GestureDetector(
                          onTap: _handleBackClick,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Transform.rotate(
                              angle: 1.5708, // 90 degrees in radians
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 30,
                                color: Color(0xFF6029B7),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 64, left: 20),
                        child: Text(
                          '새 비밀번호를 입력해주세요.',
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
