import 'package:flutter/material.dart';

// 상태 변경을 위한 Provider 클래스 정의
class MemoUpdator extends ChangeNotifier {
  List _memoList = [];
  List get memoList => _memoList;

  // 리스트 업데이트
  void updateList(List newList) {
    _memoList = newList;
    notifyListeners();
  }
}
