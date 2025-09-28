import 'package:flutter/material.dart';

/// 나눔 아이템을 표시하는 위젯
/// 이미지, 제목, 위치, 거리 정보를 포함한 개별 나눔 항목을 렌더링합니다
class SharingItem extends StatelessWidget {
  final String image; // 아이템 이미지 URL
  final String title; // 아이템 제목
  final String location; // 아이템 위치
  final String distance; // 거리 및 시간 정보

  const SharingItem({
    Key? key,
    required this.image, // 필수: 이미지 URL
    required this.title, // 필수: 제목
    required this.location, // 필수: 위치
    required this.distance, // 필수: 거리 정보
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 너비를 가져와서 반응형 디자인 적용
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 640; // 모바일 크기 판단
    final isMedium = screenWidth < 768; // 태블릿 크기 판단

    return Container(
      // 화면 크기에 따른 높이 조정 (모바일: 100, 태블릿: 120, 데스크톱: 140)
      height: isSmall ? 100 : (isMedium ? 120 : 140),
      width: 330,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD4D4D8), // 하단 경계선 (zinc-300 색상)
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          // 아이템 이미지 위치 설정
          Positioned(
            left: 0,
            top: isSmall ? 10 : (isMedium ? 0 : -5), // 화면 크기별 상단 여백 조정
            child: ClipRRect(
              // 화면 크기에 따른 모서리 둥글기 조정
              borderRadius: BorderRadius.circular(isSmall ? 8 : 16),
              child: Image.network(
                image,
                // 화면 크기별 이미지 크기 조정
                width: isSmall ? 80 : (isMedium ? 90 : 105),
                height: isSmall ? 80 : (isMedium ? 120 : 140),
                fit: BoxFit.cover, // 이미지 비율 유지하며 컨테이너 채우기
              ),
            ),
          ),
          // 텍스트 정보 영역
          Positioned(
            left: isSmall ? 96 : (isMedium ? 112 : 128), // 이미지 옆 텍스트 위치
            top: isSmall ? 10 : 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
              children: [
                // 아이템 제목
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isSmall ? 14 : 14,
                    color: const Color(0xFF18181B), // 진한 회색 (zinc-900)
                  ),
                ),
                SizedBox(height: isSmall ? 4 : 8), // 제목과 위치 사이 간격
                // 아이템 위치 (굵은 글씨)
                Text(
                  location,
                  style: TextStyle(
                    fontSize: isSmall ? 14 : 16,
                    fontWeight: FontWeight.bold, // 굵은 글씨
                    color: const Color(0xFF18181B), // 진한 회색 (zinc-900)
                  ),
                ),
                SizedBox(height: isSmall ? 4 : 8), // 위치와 거리 사이 간격
                // 거리 및 시간 정보 (연한 회색)
                Text(
                  distance,
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFFA3A3A3), // 연한 회색 (neutral-400)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
