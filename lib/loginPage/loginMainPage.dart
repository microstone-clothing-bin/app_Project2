// 로그인을 하기 위한 페이지 추가 기능 : 자동 로그인 여부, 회원가입(계정 생성) 페이지로 이동

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:microstone_clothing_bin/loginPage/header&footer.dart';
import 'package:microstone_clothing_bin/loginPage/loginDB.dart';
import 'package:microstone_clothing_bin/loginPage/memberRegisterPage.dart';
import 'logo.dart';
import 'input_field.dart';
import 'footer_links.dart';
//import 'package:shared_preferences/shared_preferences.dart';

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
      home: isToken ? MyAppPage() : LoginPage(),
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
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  // 자동 로그인 여부
  bool switchValue = false;

  // 아이디와 비밀번호 정보
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _setAutoLogin(String token) async {
    // 공유저장소에 유저 DB의 인덱스 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // 자동 로그인 해제
  void _delAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
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
                      controller: userIdController,
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
                      controller: passwordController,
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
                        backgroundColor: Color(
                          0xFF7C3AED,
                        ), // Violet-800 brand color background
                        foregroundColor:
                            Colors.white, // White text for contrast
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              64, // Wide horizontal padding for prominent button
                          vertical:
                              16, // Vertical padding for comfortable touch target
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // Rounded corners matching input fields
                        ),
                        elevation: 0, // Flat design without shadow
                      ),
                      child: Text(
                        '로그인', // Korean text for "Login"
                        style: TextStyle(
                          fontSize:
                              12, // Small text size consistent with design
                          fontWeight:
                              FontWeight.w600, // Semi-bold for button emphasis
                        ),
                      ),
                      onPressed: () async {
                        final loginCheck = await login(
                          userIdController.text,
                          passwordController.text,
                        );
                        print(loginCheck);
                        //건들지 말걸
                        // 로그인 확인
                        if (loginCheck == '-1') {
                          print('로그인 실패');
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('알림'),
                                content: Text('아이디 또는 비밀번호가 올바르지 않습니다.'),
                                actions: [
                                  TextButton(
                                    child: Text('닫기'),
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
                            MaterialPageRoute(
                              builder: (context) => MyAppPage(),
                            ),
                          );
                        }
                      },
                      //child: Text('로그인'),
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
