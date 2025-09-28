import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/Writing/sharing_post_form.dart';

/// 글 쓰기 플로팅 액션 버튼 위젯
/// 화면 우하단에 고정되어 새 글 작성 기능을 제공합니다
class WritePostButton extends StatelessWidget {
  const WritePostButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 크기에 따른 반응형 디자인 적용
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 640; // 모바일 크기 판단
    final isMedium = screenWidth < 768; // 태블릿 크기 판단

    void _handleNextClick() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SharingPostForm()),
      );
    }

    return Positioned(
      // 화면 크기별 버튼 위치 조정 (우하단 고정)
      bottom: isSmall ? 16 : (isMedium ? 20 : 144), // 하단 여백
      right: isSmall ? 16 : (isMedium ? 20 : 18), // 우측 여백
      child: GestureDetector(
        onTap:
            // TODO: 글 쓰기 버튼 클릭 시 새 글 작성 페이지로 이동
            _handleNextClick,
        child: Container(
          // 화면 크기별 버튼 크기 조정
          width: isSmall ? 60 : 70, // 너비
          height: isSmall ? 32 : 36, // 높이
          decoration: BoxDecoration(
            color: const Color(0xFF7C3AED), // 보라색 배경 (violet-800)
            borderRadius: BorderRadius.circular(16), // 둥근 모서리
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
            children: [
              // 연필 아이콘
              Container(
                width: 10,
                height: 10,
                child: CustomPaint(
                  painter: PencilIconPainter(), // 커스텀 연필 아이콘
                ),
              ),
              const SizedBox(width: 4), // 아이콘과 텍스트 사이 간격
              // '글 쓰기' 텍스트
              Text(
                '글 쓰기',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500, // 중간 굵기
                  color: Colors.white, // 흰색 텍스트
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 연필 아이콘을 그리는 커스텀 페인터 클래스
/// SVG 아이콘을 Canvas API를 사용해 직접 그립니다
class PencilIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 흰색 채우기 스타일로 페인트 설정
    final paint = Paint()
      ..color = Colors
          .white // 흰색
      ..style = PaintingStyle.fill; // 채우기 스타일

    // 연필 모양의 경로 생성 (단순화된 버전)
    final path = Path();
    // 실제 프로덕션에서는 flutter_svg 패키지 사용 권장
    path.moveTo(9.52, 0.48); // 시작점
    path.lineTo(0.61, 7.25); // 연필 몸통
    path.lineTo(0.16, 7.93); // 연필 끝
    path.lineTo(0, 8.73); // 하단부
    path.lineTo(0, 9.58); // 하단 끝
    path.lineTo(0.42, 10); // 우하단
    path.lineTo(1.27, 10); // 우측
    path.lineTo(2.75, 9.39); // 우상단
    path.lineTo(9.52, 2.61); // 상단으로 복귀
    path.close(); // 경로 닫기

    // 캔버스에 경로 그리기
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false; // 다시 그릴 필요 없음
}
