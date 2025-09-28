import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/config/mySQLConnector.dart';
import 'package:microstone_clothing_bin/join/signup_header.dart';
import 'signup_success.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String _message = "";

  final _service = RegisterService();

  // ✅ 중복 확인 상태
  bool _emailChecked = false;
  bool _usernameChecked = false;
  bool _nicknameChecked = false;

  // ✅ 비밀번호 조건
  bool _hasUpperLower = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  bool _hasValidLength = false;

  void _validatePassword(String password) {
    setState(() {
      _hasUpperLower = RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);
      _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
      _hasValidLength = password.length >= 8 && password.length <= 20;
    });
  }

  bool get _isPasswordValid =>
      _hasUpperLower && _hasNumber && _hasSpecialChar && _hasValidLength;

  bool get _isFormValid =>
      _emailChecked && _usernameChecked && _nicknameChecked && _isPasswordValid;

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _message = "비밀번호가 일치하지 않습니다.");
      return;
    }

    setState(() => _isLoading = true);
    try {
      final result = await _service.register(
        email: _emailController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
        nickname: _nicknameController.text.trim(),
      );

      setState(() {
        if (result != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  SignupSuccessPage(nickname: _nicknameController.text.trim()),
            ),
          );
        } else {
          _message = "❌ 회원가입 실패";
        }
      });
    } catch (e) {
      setState(() => _message = "에러 발생: $e");
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SignupHeader(),

                      // 이메일
                      _buildInputWithButton(
                        label: "이메일",
                        hint: "이메일 주소 입력",
                        controller: _emailController,
                        onPressed: () async {
                          final available = await _service.checkEmail(
                            _emailController.text,
                          );
                          setState(() {
                            _emailChecked = available;
                            _message = available
                                ? "사용 가능한 이메일입니다"
                                : "이미 존재하는 이메일입니다";
                          });
                        },
                      ),

                      const SizedBox(height: 20),
                      // 아이디
                      _buildInputWithButton(
                        label: "아이디",
                        hint: "아이디 입력",
                        controller: _usernameController,
                        helper: "6~12자리 이내 영문 소문자, 숫자 사용 가능",
                        onPressed: () async {
                          final available = await _service.checkUsername(
                            _usernameController.text,
                          );
                          setState(() {
                            _usernameChecked = available;
                            _message = available
                                ? "사용 가능한 아이디입니다"
                                : "이미 존재하는 아이디입니다";
                          });
                        },
                      ),

                      const SizedBox(height: 20),
                      // 비밀번호
                      _buildPasswordInput(
                        label: "비밀번호",
                        hint: "비밀번호 입력",
                        controller: _passwordController,
                        obscure: _obscurePassword,
                        toggleObscure: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                        onChanged: _validatePassword,
                      ),

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "✓ 영문 대/소문자",
                            style: TextStyle(
                              color: _hasUpperLower
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            "✓ 숫자",
                            style: TextStyle(
                              color: _hasNumber ? Colors.green : Colors.black,
                            ),
                          ),
                          Text(
                            "✓ 특수문자",
                            style: TextStyle(
                              color: _hasSpecialChar
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            "✓ 8~20자",
                            style: TextStyle(
                              color: _hasValidLength
                                  ? Colors.green
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      // 비밀번호 확인
                      _buildPasswordInput(
                        label: "비밀번호 확인",
                        hint: "비밀번호 재입력",
                        controller: _confirmPasswordController,
                        obscure: _obscureConfirmPassword,
                        toggleObscure: () => setState(
                          () => _obscureConfirmPassword =
                              !_obscureConfirmPassword,
                        ),
                      ),

                      const SizedBox(height: 20),
                      // 닉네임
                      _buildInputWithButton(
                        label: "닉네임",
                        hint: "닉네임 입력",
                        controller: _nicknameController,
                        onPressed: () async {
                          final available = await _service.checkNickname(
                            _nicknameController.text,
                          );
                          setState(() {
                            _nicknameChecked = available;
                            _message = available
                                ? "사용 가능한 닉네임입니다"
                                : "이미 존재하는 닉네임입니다";
                          });
                        },
                      ),

                      const SizedBox(height: 40),
                      // 회원가입 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: (!_isFormValid || _isLoading)
                              ? null
                              : _register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF673AB7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "회원가입",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(_message, style: const TextStyle(color: Colors.red)),
                    ],
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

/// 텍스트 입력 + 중복 확인 버튼
Widget _buildInputWithButton({
  required String label,
  required String hint,
  required TextEditingController controller,
  String? helper,
  required VoidCallback onPressed,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF673AB7),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "중복 확인",
              style: TextStyle(color: Colors.white), // ✅ 텍스트 컬러 white
            ),
          ),
        ],
      ),
      if (helper != null) ...[
        const SizedBox(height: 6),
        Text(helper, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    ],
  );
}

/// 비밀번호 입력 필드
Widget _buildPasswordInput({
  required String label,
  required String hint,
  required TextEditingController controller,
  required bool obscure,
  required VoidCallback toggleObscure,
  Function(String)? onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        obscureText: obscure,
        onChanged: onChanged, // ✅ 비밀번호 변경 감지
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          suffixIcon: IconButton(
            icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
            onPressed: toggleObscure,
          ),
        ),
      ),
    ],
  );
}
