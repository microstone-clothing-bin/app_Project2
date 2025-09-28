import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/loginPage/loginDB.dart';
import 'package:microstone_clothing_bin/loginPage/loginMainPage.dart';

// 상태 메시지 타입을 정의하는 열거형 (에러, 성공, 정보)
enum StatusType { error, success, info }

// 구분선을 표시하는 위젯
class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 네트워크에서 구분선 이미지를 가져와서 전체 너비로 표시
    return Image.network(
      'https://api.builder.io/api/v1/image/assets/TEMP/3c02d70a3938f35b1106fee63d3359c45eb30c8c?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94',
      width: double.infinity, // 전체 너비 사용
      fit: BoxFit.contain, // 이미지 비율 유지하며 컨테이너에 맞춤
    );
  }
}

// 재사용 가능한 입력 필드 위젯
class InputField extends StatelessWidget {
  final String label; // 필드 라벨 텍스트
  final String value; // 현재 입력된 값
  final String? placeholder; // 플레이스홀더 텍스트 (선택사항)
  final bool isReadOnly; // 읽기 전용 여부
  final bool isPassword; // 비밀번호 필드 여부
  final String? statusMessage; // 상태 메시지 (선택사항)
  final StatusType statusType; // 상태 메시지 타입
  final bool showIcon; // 아이콘 표시 여부
  final ValueChanged<String>? onChanged; // 값 변경 콜백 함수

  const InputField({
    Key? key,
    required this.label, // 필수: 라벨
    required this.value, // 필수: 값
    this.placeholder, // 선택: 플레이스홀더
    this.isReadOnly = false, // 기본값: 편집 가능
    this.isPassword = false, // 기본값: 일반 텍스트
    this.statusMessage, // 선택: 상태 메시지
    this.statusType = StatusType.error, // 기본값: 에러 타입
    this.showIcon = false, // 기본값: 아이콘 숨김
    this.onChanged, // 선택: 변경 콜백
  }) : super(key: key);

  // 상태 타입에 따른 색상을 반환하는 메서드
  Color _getStatusColor() {
    switch (statusType) {
      case StatusType.success:
        return const Color(0xFF16A34A); // 성공: 초록색
      case StatusType.info:
        return const Color(0xFFA3A3A3); // 정보: 회색
      case StatusType.error:
      default:
        return const Color(0xFFF87171); // 에러: 빨간색
    }
  }

  // 텍스트 색상을 결정하는 메서드
  Color _getTextColor() {
    if (isReadOnly) return const Color(0xFF18181B); // 읽기 전용: 진한 회색
    if (placeholder != null && value.isEmpty)
      return const Color(0xFFA3A3A3); // 플레이스홀더: 연한 회색
    return Colors.black; // 기본: 검은색
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        // 라벨 텍스트
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12, // 작은 폰트 크기
              fontWeight: FontWeight.w500, // 중간 굵기
              color: Color(0xFF18181B), // 진한 회색
            ),
          ),
        ),
        // 입력 필드 컨테이너
        Container(
          width: double.infinity, // 전체 너비 사용
          padding: const EdgeInsets.all(16), // 내부 여백
          decoration: BoxDecoration(
            color: Colors.white, // 흰색 배경
            borderRadius: BorderRadius.circular(8), // 둥근 모서리
            border: Border.all(
              color: const Color(0xFF7C3AED), // 보라색 테두리
              width: 1, // 테두리 두께
            ),
          ),
          child: showIcon
              ? Row(
                  // 아이콘이 있는 경우: 가로 배치
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
                  children: [
                    Text(
                      placeholder ?? value, // 플레이스홀더 또는 값 표시
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _getTextColor(), // 동적 텍스트 색상
                      ),
                    ),
                    // 오른쪽 아이콘
                    Image.network(
                      'https://api.builder.io/api/v1/image/assets/TEMP/9f179f6b17df391ad1310990332543eda20f8f49?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94',
                      width: 14,
                      height: 14,
                      fit: BoxFit.contain,
                    ),
                  ],
                )
              : Text(
                  // 아이콘이 없는 경우: 텍스트만
                  isPassword
                      ? '**************'
                      : (value.isNotEmpty ? value : placeholder ?? ''),
                  // 비밀번호면 별표, 아니면 값 또는 플레이스홀더 표시
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _getTextColor(),
                  ),
                ),
        ),
        // 상태 메시지 (있는 경우에만 표시)
        if (statusMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              statusMessage!,
              style: TextStyle(
                fontSize: 12,
                fontWeight: statusType == StatusType.info
                    ? FontWeight.w500
                    : FontWeight.normal,
                color: _getStatusColor(), // 상태에 따른 색상
              ),
            ),
          ),
      ],
    );
  }
}

// 사용자 프로필 헤더 위젯 (프로필 사진, 닉네임, 나눔 수 표시)
class ProfileHeader extends StatelessWidget {
  final String nickname; // 사용자 닉네임
  final int shareCount; // 나눔 개수
  final String avatarSrc; // 프로필 사진 URL
  final String editIconSrc; // 편집 아이콘 URL

  const ProfileHeader({
    Key? key,
    required this.nickname, // 필수: 닉네임
    required this.shareCount, // 필수: 나눔 수
    required this.avatarSrc, // 필수: 프로필 사진 URL
    required this.editIconSrc, // 필수: 편집 아이콘 URL
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 흰색 배경
      padding: const EdgeInsets.symmetric(vertical: 36), // 위아래 여백
      child: Column(
        children: [
          // 프로필 사진과 편집 버튼을 포함하는 스택
          SizedBox(
            width: 140,
            height: 140,
            child: Stack(
              children: [
                // 원형 프로필 사진 컨테이너
                Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, // 원형 모양
                  ),
                  child: ClipOval(
                    // 원형으로 이미지 자르기
                    child: Image.network(
                      avatarSrc, // 프로필 사진 URL
                      fit: BoxFit.cover, // 이미지를 컨테이너에 맞게 자르기
                      width: 140,
                      height: 140,
                    ),
                  ),
                ),
                // 편집 아이콘 (오른쪽 하단에 위치)
                Positioned(
                  bottom: 0, // 하단에 위치
                  right: 0, // 오른쪽에 위치
                  child: GestureDetector(
                    onTap: () {
                      // 프로필 사진 편집 기능 처리
                      // TODO: 프로필 사진 편집 로직 구현
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8), // 터치 영역 확대를 위한 패딩
                      child: Image.network(
                        editIconSrc, // 편집 아이콘 URL
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16), // 프로필 사진과 닉네임 사이 간격
          // 사용자 닉네임
          Text(
            nickname,
            style: const TextStyle(
              fontSize: 16, // 중간 크기 폰트
              fontWeight: FontWeight.w500, // 중간 굵기
              color: Color(0xFF18181B), // 진한 회색
            ),
          ),
          const SizedBox(height: 4), // 닉네임과 나눔 수 사이 간격
          // 나눔 수 표시
          Text(
            '나눔 수 : ${shareCount}개',
            style: const TextStyle(
              fontSize: 12, // 작은 폰트
              fontWeight: FontWeight.w500,
              color: Color(0xFFA3A3A3), // 연한 회색
            ),
          ),
        ],
      ),
    );
  }
}

// 계정 정보 섹션 위젯 (아이디, 이메일, 닉네임 - 모두 읽기 전용)
class AccountInfo extends StatelessWidget {
  final String userId; // 사용자 아이디
  final String email; // 사용자 이메일
  final String nickname; // 사용자 닉네임

  const AccountInfo({
    Key? key,
    required this.userId, // 필수: 사용자 아이디
    required this.email, // 필수: 이메일
    required this.nickname, // 필수: 닉네임
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        // 섹션 제목
        const Padding(
          padding: EdgeInsets.only(bottom: 32), // 제목 아래 여백
          child: Text(
            '회원정보',
            style: TextStyle(
              fontSize: 14, // 제목 폰트 크기
              fontWeight: FontWeight.w600, // 굵은 글씨
              color: Color(0xFF18181B), // 진한 회색
            ),
          ),
        ),
        // 입력 필드들을 세로로 배치
        Column(
          children: [
            // 아이디 필드 (읽기 전용)
            InputField(
              label: '아이디',
              value: userId,
              isReadOnly: true, // 편집 불가
              statusMessage: '변경 불가능합니다.',
              statusType: StatusType.error, // 에러 스타일 (빨간색)
            ),
            const SizedBox(height: 20), // 필드 간 간격
            // 이메일 필드 (읽기 전용)
            InputField(
              label: '이메일',
              value: email,
              isReadOnly: true, // 편집 불가
              statusMessage: '변경 불가능합니다.',
              statusType: StatusType.error, // 에러 스타일 (빨간색)
            ),
            const SizedBox(height: 20), // 필드 간 간격
            // 닉네임 필드 (읽기 전용)
            InputField(
              label: '닉네임',
              value: nickname,
              isReadOnly: true, // 편집 불가
              statusMessage: '변경 불가능합니다.',
              statusType: StatusType.error, // 에러 스타일 (빨간색)
            ),
          ],
        ),
      ],
    );
  }
}

// 계정 수정 섹션 위젯 (비밀번호 변경 기능)
class AccountModification extends StatefulWidget {
  const AccountModification({Key? key}) : super(key: key);

  @override
  State<AccountModification> createState() => _AccountModificationState();
}

// AccountModification의 상태를 관리하는 클래스
class _AccountModificationState extends State<AccountModification> {
  String passwordConfirm = ''; // 비밀번호 확인 입력값을 저장하는 변수

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        // 섹션 제목
        const Padding(
          padding: EdgeInsets.only(bottom: 32), // 제목 아래 여백
          child: Text(
            '회원정보 수정',
            style: TextStyle(
              fontSize: 14, // 제목 폰트 크기
              fontWeight: FontWeight.w600, // 굵은 글씨
              color: Color(0xFF18181B), // 진한 회색
            ),
          ),
        ),
        // 비밀번호 관련 입력 필드들
        Column(
          children: [
            // 현재 비밀번호 필드 (별표로 표시)
            const InputField(
              label: '비밀번호',
              value: '', // 빈 값 (실제로는 별표로 표시됨)
              isPassword: true, // 비밀번호 필드로 설정
              statusMessage: '변경 가능합니다.',
              statusType: StatusType.success, // 성공 스타일 (초록색)
            ),
            const SizedBox(height: 24), // 필드 간 간격
            // 비밀번호 확인 필드 (사용자 입력 가능)
            InputField(
              label: '비밀번호 확인',
              value: passwordConfirm, // 상태 변수와 연결
              placeholder: '새 비밀번호 재입력', // 플레이스홀더 텍스트
              showIcon: true, // 오른쪽에 아이콘 표시
              statusMessage: '비밀번호 변경 시 입력해주세요.',
              statusType: StatusType.info, // 정보 스타일 (회색)
              onChanged: (value) {
                // 값이 변경될 때 호출되는 콜백
                setState(() {
                  passwordConfirm = value; // 상태 업데이트
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 24), // 필드와 버튼 사이 간격
        // 저장 버튼 (오른쪽 정렬)
        Align(
          alignment: Alignment.centerRight, // 오른쪽 정렬
          child: GestureDetector(
            onTap: () {
              // 변경사항 저장 로직 처리
              // TODO: 실제 비밀번호 변경 API 호출 구현
            },
            child: Container(
              padding: const EdgeInsets.all(16), // 버튼 내부 여백
              decoration: BoxDecoration(
                color: const Color(0xFF7C3AED), // 보라색 배경
                borderRadius: BorderRadius.circular(8), // 둥근 모서리
              ),
              child: const Text(
                '변경된 정보 저장',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600, // 굵은 글씨
                  color: Colors.white, // 흰색 텍스트
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 계정 보안 섹션 위젯 (로그아웃, 회원 탈퇴 기능)
class AccountSecurity extends StatelessWidget {
  const AccountSecurity({Key? key}) : super(key: key);

  // 회원 탈퇴 처리 메서드
  void _handleDeleteAccount() {
    // 실제 회원 탈퇴 로직이 여기에 구현됨
    // TODO: 확인 다이얼로그 표시, 회원 탈퇴 API 호출 등
    print('회원 탈퇴 버튼 클릭됨');
  }

  @override
  Widget build(BuildContext context) {
    // 로그아웃 처리 메서드
    void _handleLogout() {
      // 실제 로그아웃 로직이 여기에 구현됨
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginMainPage()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        // 섹션 제목
        const Padding(
          padding: EdgeInsets.only(bottom: 32), // 제목 아래 여백
          child: Text(
            '계정 보안',
            style: TextStyle(
              fontSize: 14, // 제목 폰트 크기
              fontWeight: FontWeight.w600, // 굵은 글씨
              color: Color(0xFF18181B), // 진한 회색
            ),
          ),
        ),
        // 버튼들을 오른쪽에 정렬
        Align(
          alignment: Alignment.centerRight, // 오른쪽 정렬
          child: SizedBox(
            width: 296, // 고정 너비
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝 정렬
              children: [
                // 로그아웃 버튼 (보라색 배경)
                GestureDetector(
                  onTap: _handleLogout, // 로그아웃 메서드 호출
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ), // 버튼 내부 여백
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C3AED), // 보라색 배경
                      borderRadius: BorderRadius.circular(8), // 둥근 모서리
                    ),
                    child: const Text(
                      '로그아웃',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600, // 굵은 글씨
                        color: Colors.white, // 흰색 텍스트
                      ),
                    ),
                  ),
                ),
                // 회원 탈퇴 관련 컬럼 (버튼 + 경고 메시지)
                Column(
                  children: [
                    // 회원 탈퇴 버튼 (흰색 배경, 보라색 테두리)
                    GestureDetector(
                      onTap: _handleDeleteAccount, // 회원 탈퇴 메서드 호출
                      child: Container(
                        width: 110, // 고정 너비
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ), // 버튼 내부 여백
                        decoration: BoxDecoration(
                          color: Colors.white, // 흰색 배경
                          borderRadius: BorderRadius.circular(8), // 둥근 모서리
                          border: Border.all(
                            color: const Color(0xFF7C3AED), // 보라색 테두리
                            width: 1, // 테두리 두께
                          ),
                        ),
                        child: const Text(
                          '회원탈퇴',
                          textAlign: TextAlign.center, // 가운데 정렬
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600, // 굵은 글씨
                            color: Color(0xFF7C3AED), // 보라색 텍스트
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// 메인 사용자 프로필 화면 위젯
// 모든 하위 컴포넌트들을 조합하여 완전한 마이페이지를 구성
class BottomIcon3 extends StatelessWidget {
  const BottomIcon3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 모의 데이터 - 실제 앱에서는 API나 상태 관리에서 가져올 데이터
    const userData = {
      'nickname': 'user nickname1', // 사용자 닉네임
      'shareCount': 2, // 나눔 개수
      'userId': 'qwer1234', // 사용자 아이디
      'email': 'qwer1234@gmail.com', // 사용자 이메일
      'avatarSrc':
          'https://api.builder.io/api/v1/image/assets/TEMP/154f52ed7e8608a9723e4fcbde8a2b594596559e?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94', // 프로필 사진 URL
      'editIconSrc':
          'https://api.builder.io/api/v1/image/assets/TEMP/ece63955a45050a054775d536e2ad22016385a26?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94', // 편집 아이콘 URL
    };

    return Scaffold(
      backgroundColor: Colors.white, // 전체 배경색: 흰색
      body: SingleChildScrollView(
        // 스크롤 가능한 컨테이너
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 480,
          ), // 최대 너비 제한 (모바일 최적화)
          margin: const EdgeInsets.symmetric(horizontal: 32), // 좌우 여백
          padding: const EdgeInsets.only(top: 48), // 상단 여백
          child: Column(
            children: [
              // 1. 프로필 헤더 섹션 (프로필 사진, 닉네임, 나눔 수)
              ProfileHeader(
                nickname: userData['nickname'] as String,
                shareCount: userData['shareCount'] as int,
                avatarSrc: userData['avatarSrc'] as String,
                editIconSrc: userData['editIconSrc'] as String,
              ),

              // 구분선
              const DividerWidget(),

              const SizedBox(height: 20), // 섹션 간 간격
              // 2. 회원정보 섹션 (아이디, 이메일, 닉네임 - 읽기 전용)
              AccountInfo(
                userId: userData['userId'] as String,
                email: userData['email'] as String,
                nickname: userData['nickname'] as String,
              ),

              const SizedBox(height: 32), // 섹션 간 간격
              const DividerWidget(), // 구분선

              const SizedBox(height: 16), // 섹션 간 간격
              // 3. 회원정보 수정 섹션 (비밀번호 변경)
              const AccountModification(),

              const SizedBox(height: 32), // 섹션 간 간격
              const DividerWidget(), // 구분선

              const SizedBox(height: 16), // 섹션 간 간격
              // 4. 계정 보안 섹션 (로그아웃, 회원 탈퇴)
              const AccountSecurity(),

              const SizedBox(height: 32), // 하단 여백
            ],
          ),
        ),
      ),
    );
  }
}
