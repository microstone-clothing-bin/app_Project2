import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/Sharing/listing_header.dart'; // 목록 헤더 위젯
import 'package:microstone_clothing_bin/Sharing/sharing_item.dart'; // 개별 나눔 아이템 위젯
import 'package:microstone_clothing_bin/Sharing/write_post_button.dart'; // 글 쓰기 버튼 위젯

class BottomIcon1 extends StatelessWidget {
  const BottomIcon1({super.key});

  /// 나눔 아이템 데이터 목록 (실제 앱에서는 API에서 가져올 데이터)
  static const List<Map<String, dynamic>> sharingItems = [
    {
      'id': 1, // 아이템 고유 ID
      'image':
          'https://api.builder.io/api/v1/image/assets/TEMP/ffc9adb2a0ef33524a18a64ccef820ae8b9fce7a?width=210',
      'title': '나눔', // 아이템 제목
      'location': '안동시 풍천면 갈전리 1161', // 위치 정보
      'distance': '내 위치에서 10M | 2시간 전', // 거리 및 게시 시간
    },
    {
      'id': 2,
      'image':
          'https://api.builder.io/api/v1/image/assets/TEMP/c2807f26913b41b772172065d52c266fa4523b3b?width=210',
      'title': '청셔츠 나눔해요',
      'location': '송파구 잠실동 42-8',
      'distance': '내 위치에서 23KM | 1시간 전',
    },
    {
      'id': 3,
      'image':
          'https://api.builder.io/api/v1/image/assets/TEMP/edfa106d9531c522347f909e19f58e27ee5a7610?width=210',
      'title': '항공점퍼',
      'location': '파주시 금촌동 64-1',
      'distance': '내 위치에서 30KM | 2분 전',
    },
    {
      'id': 4,
      'image':
          'https://api.builder.io/api/v1/image/assets/TEMP/f68515ec3927c50685a4fffbbab5f543b40dc6d4?width=210',
      'title': '한번 입은 티셔츠 사이즈 미스로 나눔',
      'location': '광산구 연산동 1000',
      'distance': '내 위치에서 70KM | 1시간 전',
    },
    {
      'id': 5,
      'image':
          'https://api.builder.io/api/v1/image/assets/TEMP/10d2ce48bfcba84ac083179fd091f0e12b20e5c5?width=210',
      'title': '자라 블라우스 나눔합니다 필요하신',
      'location': '전주시 서노송동 568-11',
      'distance': '내 위치에서 398KM | 32분 전',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 화면 크기 정보 가져오기
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmall = screenWidth < 640; // 모바일 화면 여부
    final isMedium = screenWidth < 768; // 태블릿 화면 여부

    return Scaffold(
      backgroundColor: Colors.white, // 흰색 배경
      body: Container(
        // 화면 크기에 따른 컨테이너 크기 설정
        width: isMedium ? double.infinity : 390, // 너비 (태블릿 이상: 전체, 모바일: 390)
        height: isMedium ? double.infinity : 844, // 높이 (태블릿 이상: 전체, 모바일: 844)
        constraints: BoxConstraints(
          maxWidth: isMedium ? double.infinity : 390, // 최대 너비 제한
          minHeight: isMedium ? screenHeight : 844, // 최소 높이 설정
        ),
        child: Stack(
          children: [
            // 메인 콘텐츠 영역 (목록 헤더 + 나눔 아이템들)
            Positioned(
              left: isSmall ? 16 : (isMedium ? 20 : 30), // 좌측 여백
              top: isSmall ? 16 : (isMedium ? 20 : 67), // 상단 여백
              child: Container(
                // 콘텐츠 영역 너비 계산 (화면 너비 - 좌우 여백)
                width: isSmall
                    ? screenWidth -
                          32 // 모바일: 전체 너비 - 32px
                    : (isMedium
                          ? screenWidth - 40
                          : 330), // 태블릿: 전체 너비 - 40px, 데스크톱: 330px
                height: isMedium ? null : 693, // 태블릿 이상에서는 높이 자동 조정
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // 하단 정렬
                  children: [
                    // 목록 헤더 (아이템 개수 + 정렬 옵션)
                    const ListingHeader(),
                    // 나눔 아이템 목록
                    Column(
                      children: sharingItems.map((item) {
                        return SharingItem(
                          image: item['image'], // 아이템 이미지
                          title: item['title'], // 아이템 제목
                          location: item['location'], // 아이템 위치
                          distance: item['distance'], // 거리 정보
                        );
                      }).toList(),
                    ),
                    // 태블릿 이상에서 하단 여백 추가 (플로팅 버튼과의 간격)
                    if (isMedium) const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            // 플로팅 액션 버튼 (글 쓰기)
            const WritePostButton(),
          ],
        ),
      ),
    );
  }
}
