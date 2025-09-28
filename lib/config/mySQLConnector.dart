import 'package:mysql_client/mysql_client.dart';

// SQL 접속 설정의 정보를 저장하기 위한 dart 파일 생성

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String baseUrl =
      "https://backend-server-z67l.onrender.com/api/user/register";

  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      // ✅ POST + JSON 방식 요청
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Content-Type": "application/json", // JSON 전송
        },
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        // 서버에서 내려주는 JSON 응답 파싱
        return jsonDecode(response.body);
      } else {
        print("로그인 실패: ${response.statusCode} / ${response.body}");
        return null;
      }
    } catch (e) {
      print("에러 발생: $e");
      return null;
    }
  }
}

class RegisterService {
  final String baseUrl =
      "https://backend-server-z67l.onrender.com/api/user/register";

  /// 아이디 중복 확인
  Future<bool> checkUsername(String username) async {
    final url = Uri.parse("$baseUrl/api/user/check-id?id=$username");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("중복확인");
      return data["available"] ?? false; // {"available": true/false}
    } else {
      throw Exception("아이디 중복 확인 실패: ${response.body}");
    }
  }

  /// 이메일 중복 확인
  Future<bool> checkEmail(String email) async {
    final url = Uri.parse("$baseUrl/api/user/check-email?email=$email");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["available"] ?? false;
    } else {
      throw Exception("이메일 중복 확인 실패: ${response.body}");
    }
  }

  /// 닉네임 중복 확인
  Future<bool> checkNickname(String nickname) async {
    final url = Uri.parse(
      "$baseUrl/api/user/check-nickname?nickname=$nickname",
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["available"] ?? false;
    } else {
      throw Exception("닉네임 중복 확인 실패: ${response.body}");
    }
  }

  // 회원가입 요청 함수
  Future<Map<String, dynamic>?> register({
    required String email,
    required String username,
    required String password,
    required String nickname,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
          "nickname": nickname,
        }),
      );

      if (response.statusCode == 200) {
        // 서버에서 내려주는 JSON 응답
        return jsonDecode(response.body);
      } else {
        print("회원가입 실패: ${response.statusCode} / ${response.body}");
        return null;
      }
    } catch (e) {
      print("에러 발생: $e");
      return null;
    }
  }
}

class Board {
  final int id; // 게시글 ID
  final String photo; // 사진 URL
  final String title; // 글제목
  final String content; // 글내용
  final String address; // 주소

  Board({
    required this.id,
    required this.photo,
    required this.title,
    required this.content,
    required this.address,
  });

  // JSON → Dart 객체 변환
  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['id'] ?? 0,
      photo: json['photo'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      address: json['address'] ?? '',
    );
  }

  // Dart 객체 → JSON 변환 (서버로 전송할 때 사용 가능)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "photo": photo,
      "title": title,
      "content": content,
      "address": address,
    };
  }
}

class BoardService {
  final String baseUrl = "https://backend-server-z67l.onrender.com/api/boards";

  /// 게시글 목록 가져오기 (GET)
  Future<List<Board>> fetchBoards() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Board.fromJson(json)).toList();
    } else {
      throw Exception("게시글 불러오기 실패: ${response.statusCode}");
    }
  }

  /// 게시글 작성 (POST)
  Future<Board> createBoard(Board board) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(board.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Board.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("게시글 작성 실패: ${response.statusCode}");
    }
  }
}

// MySQL 접속
/* */
Future<MySQLConnection> dbConnector() async {
  print("Connecting to mysql server...");

  // MySQL 접속 설정
  final conn = await MySQLConnection.createConnection(
    host: 'BOOK-EAFELAOPOK',
    port: 3306,
    userName: 'root',
    password: '0000',
    databaseName: 'tast_sql', // optional
  );

  await conn.connect();

  print("Connected");

  return conn;
}
