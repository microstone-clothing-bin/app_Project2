// 로그인을 하기 위한 페이지 추가 기능 : 자동 로그인 여부, 회원가입(계정 생성) 페이지로 이동

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:microstone_clothing_bin/main.dart';
import 'package:microstone_clothing_bin/config/mySQLConnector.dart';

import 'logo.dart';
import 'input_field.dart';
import 'package:microstone_clothing_bin/loginPage/footer_links.dart';

// 자동 로그인 확인
// 토큰 있음 : 메인 페이지
// 토큰 없음 : 로그인 화면
class TokenCheck extends StatefulWidget {
  const TokenCheck({super.key});

  @override
  State<TokenCheck> createState() => _TokenCheckState();
}

class _TokenCheckState extends State<TokenCheck> {
  bool isToken = false;

  @override
  void initState() {
    super.initState();
    _autoLoginCheck();
  }

  void _autoLoginCheck() async {
    // SharedPreferences 값 저장하기 자동로그인을 위해서 사용자 정보 기억하기
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      setState(() {
        isToken = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isToken ? MyApp() : LoginPage(),
    );
  }
}

// 로그인 페이지
class LoginMainPage extends StatelessWidget {
  const LoginMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 자동 로그인 여부
  bool switchValue = false;

  // 아이디와 비밀번호 정보
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();

  bool _isLoading = false;
  bool _autoLogin = false;
  String _message = "";

  // 자동 로그인 저장
  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // 자동 로그인 해제
  Future<void> _removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // 로그인 실행
  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _message = "";
      if (_loginService == '-1') {
        print('로그인 실패');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('알림'),
              content: const Text('아이디 또는 비밀번호가 올바르지 않습니다.'),
              actions: [
                TextButton(
                  child: const Text('닫기'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        print('로그인 성공');

        // 메인 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      }
    });

    final result = await _loginService.login(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _isLoading = false;
      if (result != null && result['token'] != null) {
        _message = "로그인 성공!";

        // 자동 로그인 설정
        if (_autoLogin) {
          _saveToken(result['token']);
        } else {
          _removeToken();
        }

        // TODO: 메인 페이지 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MyApp()),
        );
      } else {
        _message = "로그인 실패! 아이디/비밀번호를 확인하세요.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //로고
                Logo(),
                SizedBox(height: 64),
                // ID 입력 텍스트필드
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: CupertinoTextField(
                      controller: _usernameController,
                      placeholder: '아이디',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // 비밀번호 입력 텍스트필드
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: CupertinoTextField(
                      controller: _passwordController,
                      placeholder: '비밀번호',
                      textAlign: TextAlign.center,
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(height: 36),

                // 로그인 버튼
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C3AED), // 보라색 배경
                        foregroundColor: Colors.white, // 흰색 텍스트
                        padding: const EdgeInsets.symmetric(
                          horizontal: 64,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0, // 그림자 제거
                      ),
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              '로그인',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
                // 자동 로그인 확인 토글 스위치
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '자동로그인 ',
                        style: TextStyle(
                          color: CupertinoColors.systemPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CupertinoSwitch(
                        // 부울 값으로 스위치 토글 (value)
                        value: switchValue,
                        activeColor: CupertinoColors.systemPurple,
                        onChanged: (bool? value) {
                          // 스위치가 토글될 때 실행될 코드
                          setState(() {
                            switchValue = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // 하단바 3
                FooterLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
