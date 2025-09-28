import 'package:flutter/material.dart';

/// 나눔 목록의 헤더 위젯
/// 총 아이템 개수와 정렬 옵션(거리순, 최신순)을 표시합니다
class ListingHeader extends StatelessWidget {
  const ListingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 너비를 가져와서 반응형 레이아웃 결정
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < 640; // 모바일 화면 여부 판단

    return Container(
      width: 330,
      margin: EdgeInsets.only(bottom: isSmall ? 16 : 24), // 하단 여백 조정
      child: isSmall
          ? // 모바일: 세로 레이아웃 (아이템 개수 위, 정렬 버튼 아래)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 총 아이템 개수 표시
                const Text(
                  '4,325개',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500, // 중간 굵기
                    color: Color(0xFF18181B), // 진한 회색 (zinc-900)
                  ),
                ),
                const SizedBox(height: 8), // 개수와 정렬 버튼 사이 간격
                // 정렬 버튼들을 오른쪽 정렬
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildSortButton('거리순'), // 거리순 정렬 버튼
                    const SizedBox(width: 8), // 버튼 사이 간격
                    _buildSortButton('최신순'), // 최신순 정렬 버튼
                  ],
                ),
              ],
            )
          : // 데스크톱/태블릿: 가로 레이아웃 (양쪽 끝 정렬)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 왼쪽: 총 아이템 개수
                const Text(
                  '4,325개',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500, // 중간 굵기
                    color: Color(0xFF18181B), // 진한 회색 (zinc-900)
                  ),
                ),
                // 오른쪽: 정렬 옵션 버튼들
                Row(
                  children: [
                    _buildSortButton('거리순'), // 거리순 정렬 버튼
                    const SizedBox(width: 8), // 버튼 사이 간격
                    _buildSortButton('최신순'), // 최신순 정렬 버튼
                  ],
                ),
              ],
            ),
    );
  }

  /// 정렬 버튼을 생성하는 헬퍼 메서드
  /// [text]: 버튼에 표시될 텍스트 (예: '거리순', '최신순')
  Widget _buildSortButton(String text) {
    return GestureDetector(
      onTap: () {
        // TODO: 정렬 버튼 클릭 시 처리 로직 구현
        print('$text 버튼이 클릭되었습니다');
      },
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500, // 중간 굵기
          color: Color(0xFFA3A3A3), // 연한 회색 (neutral-400)
        ),
      ),
    );
  }
}
