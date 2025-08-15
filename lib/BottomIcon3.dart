import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/loginPage/loginDB.dart';

class BottomIcon3 extends StatelessWidget {
  const BottomIcon3({super.key});

  @override
  Widget build(BuildContext context) {
    if (LoginState().isLoggedIn) {
      print("현재 로그인 중입니다.");
    } else {
      print("로그아웃 상태입니다.");
    }
    return Scaffold(
      body: const Center(
        child: Text('홈 화면 TEST', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
