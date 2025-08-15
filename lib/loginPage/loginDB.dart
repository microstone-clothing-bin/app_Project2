// MySQL의 쿼리를 수행하기 위한 코드가 있는 파일 회원가입(계정 생성), 유저ID 중복확인, 로그인

import 'package:microstone_clothing_bin/config/mySqlConnector.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:microstone_clothing_bin/config/hashPassword.dart';

// 계정 생성
Future<void> insertMember(String userName, String password) async {
  // MySQL 접속 설정
  final conn = await dbConnector();

  // 비밀번호 암호화
  final hash = hashPassword(password);

  // DB에 유저 정보 추가
  try {
    await conn.execute(
      "INSERT INTO users (userName, password) VALUES (:userName, :password)",
      {"userName": userName, "password": hash},
    );
    print(hash);
  } catch (e) {
    print('Error : $e');
  } finally {
    await conn.close();
  }
}

// 로그인
Future<String?> login(String userName, String password) async {
  // MySQL 접속 설정
  final conn = await dbConnector();

  // 비밀번호 암호화
  final hash = hashPassword(password);

  // 쿼리 수행 결과 저장 변수
  IResultSet? result;

  // DB에 해당 유저의 아이디와 비밀번호를 확인하여 users 테이블에 있는지 확인
  try {
    result = await conn.execute(
      "SELECT id FROM users WHERE userName = :userName and password = :password",
      {"userName": userName, "password": hash},
    );

    if (result.isNotEmpty) {
      for (final row in result.rows) {
        print(row.assoc());
        // 유저 정보가 존재하면 유저의 index 값 반환
        return row.colAt(0);
      }
    }
  } catch (e) {
    print('Error : $e');
  } finally {
    await conn.close();
  }
  // 예외처리용 에러코드 '-1' 반환
  return '-1';
}

// 유저ID 중복확인
Future<String?> confirmIdCheck(String userName) async {
  // MySQL 접속 설정
  final conn = await dbConnector();

  // 쿼리 수행 결과 저장 변수
  IResultSet? result;

  // ID 중복 확인
  try {
    // 아이디가 중복이면 1 값 반환, 중복이 아니면 0 값 반환
    result = await conn.execute(
      "SELECT IFNULL((SELECT userName FROM users WHERE userName=:userName), 0) as idCheck",
      {"userName": userName},
    );

    if (result.isNotEmpty) {
      for (final row in result.rows) {
        return row.colAt(0);
      }
    }
  } catch (e) {
    print('Error : $e');
  } finally {
    await conn.close();
  }
  // 예외처리용 에러코드 '-1' 반환
  return '-1';
}

class LoginState {
  // 싱글톤 패턴으로 로그인 상태를 전역에서 하나만 유지
  static final LoginState _instance = LoginState._internal();

  // 현재 로그인한 유저 ID (로그인 안 되어 있으면 null)
  String? _userId;

  // private 생성자 (외부에서 new 금지)
  LoginState._internal();

  // 싱글톤 인스턴스 반환
  factory LoginState() {
    return _instance;
  }

  // 로그인 상태 설정
  void setLogin(String userId) {
    _userId = userId;
  }

  // 로그인 상태 해제
  void logout() {
    _userId = null;
  }

  // 현재 로그인 여부 반환
  bool get isLoggedIn => _userId != null && _userId != '-1';

  // 현재 로그인한 유저 ID 반환
  String? get userId => _userId;
}
