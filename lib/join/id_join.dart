import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/join/pw/pw_main_step.dart';
import 'package:microstone_clothing_bin/join/signup_header.dart';
import 'package:microstone_clothing_bin/loginPage/loginDB.dart';

enum ButtonVariant { primary, secondary }

enum ButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String text;
  final ButtonVariant variant;
  final ButtonSize size;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    EdgeInsets padding;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = const Color(0xFF7C3AED); // violet-800
        break;
      case ButtonVariant.secondary:
        backgroundColor = const Color(0xFFA78BFA); // violet-300
        break;
    }

    switch (size) {
      case ButtonSize.small:
        padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 16);
        break;
      case ButtonSize.medium:
        padding = const EdgeInsets.symmetric(horizontal: 64, vertical: 16);
        break;
      case ButtonSize.large:
        padding = const EdgeInsets.symmetric(horizontal: 80, vertical: 24);
        break;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}

class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps, (index) {
          final stepNumber = index + 1;
          final isActive = stepNumber == currentStep;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF7C3AED) // violet-800
                  : const Color(0xFFA78BFA), // violet-300
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  final String label;
  final String placeholder;
  final String? helpText;
  final bool showDuplicateCheck;
  final VoidCallback? onDuplicateCheck;

  const InputField({
    Key? key,
    required this.label,
    required this.placeholder,
    this.helpText,
    this.showDuplicateCheck = false,
    this.onDuplicateCheck,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController userIdController = TextEditingController();

  @override
  void dispose() {
    userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 48, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF18181B), // zinc-900
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
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
                        controller: userIdController,
                        decoration: InputDecoration(
                          hintText: widget.placeholder,
                          hintStyle: const TextStyle(
                            color: Color(0xFFA3A3A3), // neutral-400
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (widget.helpText != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          widget.helpText!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFA3A3A3), // neutral-400
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (widget.showDuplicateCheck) ...[
                const SizedBox(width: 4),
                CustomButton(
                  text: "중복 확인",
                  variant: ButtonVariant.primary,
                  size: ButtonSize.small,
                  onPressed: () async {
                    final IDCheck = await confirmIdCheck(userIdController.text);
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class IdJoinForm extends StatefulWidget {
  const IdJoinForm({Key? key}) : super(key: key);

  @override
  State<IdJoinForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<IdJoinForm> {
  void _handleDuplicateCheck() {
    // Handle duplicate check logic
    print("Checking for duplicates...");
  }

  void _handleNext() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PwMainStep()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 500;
    final isMobile = screenWidth <= 390;

    final containerWidth = isMobile ? screenWidth : (isTablet ? 500.0 : 390.0);
    final containerHeight = screenHeight < 844 ? screenHeight : 844.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
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

                        // Step Indicator
                        const StepIndicator(currentStep: 2, totalSteps: 5),

                        // Main Content
                        Container(
                          margin: const EdgeInsets.only(top: 64, left: 20),
                          child: const Text(
                            "아이디를 입력해주세요.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF18181B), // zinc-900
                            ),
                          ),
                        ),

                        // Input Field
                        InputField(
                          label: "아이디",
                          placeholder: "아이디 입력",
                          helpText: "6~12자리 이내 영문 소문자, 숫자 사용 가능",
                          showDuplicateCheck: true,
                          onDuplicateCheck: _handleDuplicateCheck,
                        ),

                        // Spacer
                        const SizedBox(height: 30),

                        // Next Button
                        Positioned(
                          bottom: 62,
                          left: isMobile
                              ? screenWidth * 0.08
                              : (isTablet ? screenWidth * 0.06 : 30),
                          right: isMobile
                              ? screenWidth * 0.08
                              : (isTablet ? screenWidth * 0.06 : 30),
                          child: GestureDetector(
                            onTap: _handleNext,
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6029B7),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '다음으로',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
