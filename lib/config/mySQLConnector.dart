import 'package:mysql_client/mysql_client.dart';

// MySQL 접속 설정의 정보를 저장하기 위한 dart 파일 생성

/* mySqlConnector.dart */
import 'package:mysql_client/mysql_client.dart';
import 'package:flutter_test/flutter_test.dart';

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
