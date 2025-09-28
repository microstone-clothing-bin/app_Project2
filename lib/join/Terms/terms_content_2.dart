import 'package:flutter/material.dart';

class TermsContent2 extends StatelessWidget {
  const TermsContent2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32, left: 20, right: 20),
      padding: const EdgeInsets.only(top: 4, bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제1조
          _buildSectionWithList(
            title: '1. 수집하는 개인정보 항목',
            items: ['회사는 회원가입 및 서비스 이용 과정에서 다음과 같은 개인정보를 수집합니다.'],
            subItems: [
              '필수 항목: 아이디, 비밀번호, 닉네임, 이메일',
              '서비스 이용 중 자동 수집 항목: 접속 IP, 방문 일시, 이용 기록, 쿠키 (로그 분석 및 보안 목적)',
            ],
            footer:
                '※ 커뮤니티 이용 과정에서 사용자가 자발적으로 입력하는 정보(게시글, 나눔 위치 등)는 이용자가 공개한 것으로 간주됩니다.',
          ),
          const SizedBox(height: 16),

          // 제2조
          _buildSectionWithList(
            title: '2. 개인정보 수집 및 이용 목적',
            items: ['회사는 수집한 개인정보를 다음의 목적에 한하여 사용합니다.'],
            subItems: [
              '회원 가입 및 서비스 이용자 식별, 로그인 기능 제공',
              '커뮤니티 내 글 작성 및 나눔 게시글 운영',
              '의류수거함 위치 기반 안내 서비스 제공',
              '공지사항, 서비스 관련 안내 전달',
              '부정이용 방지, 고객 문의 응대 및 민원 처리',
              '서비스 개선 및 통계 분석',
            ],
          ),
          const SizedBox(height: 16),

          // 제3조
          _buildSectionWithList(
            title: '3. 개인정보 보유 및 이용 기간',
            items: [
              '회원 탈퇴 시까지 또는 수집·이용 목적이 달성될 때까지 보관 후 지체 없이 파기',
              '단, 다음의 경우 관련 법령에 따라 일정 기간 보관',
            ],
            subItems: [
              '「전자상거래법」 계약 또는 청약철회 기록: 5년',
              '「통신비밀보호법」 로그인 기록(IP 등): 3개월',
            ],
          ),
          const SizedBox(height: 16),

          // 제4조
          _buildSectionWithList(
            title: '4. 개인정보 제공 및 위탁',
            subItems: [
              '회사는 원칙적으로 개인정보를 외부에 제공하지 않으며, 필요한 경우 사전에 명확히 고지하고 동의를 받습니다.',
              '서버 운영 등 기술적 관리를 위탁하는 경우, 수탁사 정보를 이용약관 또는 별도 고지사항을 통해 안내합니다.',
            ],
          ),
          const SizedBox(height: 16),

          // 제5조
          _buildSectionWithList(
            title: '5. 이용자의 권리',
            subItems: [
              '이용자는 언제든지 개인정보 열람, 수정, 삭제, 처리 정지를 요청할 수 있습니다.',
              '회원 탈퇴 시에는 모든 개인정보가 즉시 삭제됩니다(단, 법적 보관 항목 제외).',
            ],
          ),
          const SizedBox(height: 16),

          // 제6조
          _buildSectionWithList(
            title: '6. 개인정보 수집 동의 거부 권리 및 불이익',
            subItems: [
              '회원은 개인정보 제공 및 이용 동의를 거부할 수 있습니다.',
              '단, 필수 항목에 대한 동의를 거부할 경우, 서비스 이용(회원가입 등)이 제한될 수 있습니다.',
            ],
          ),
        ],
      ),
    );
  }

  /// 제목 + 리스트
  Widget _buildSectionWithList({
    required String title,
    List<String>? items,
    List<String>? subItems,
    String? footer,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
            fontSize: 12,
            color: Color(0xFF18181B),
          ),
        ),
        const SizedBox(height: 4),

        // 일반 문장 리스트
        if (items != null) ...[
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Text(
                item,
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF18181B),
                ),
              ),
            ),
          ),
        ],

        // 불릿 리스트
        if (subItems != null) ...[
          ...subItems.map(
            (subItem) => Padding(
              padding: const EdgeInsets.only(left: 32, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xFF18181B),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      subItem,
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFF18181B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],

        // footer (※ 안내문)
        if (footer != null) ...[
          const SizedBox(height: 8),
          Text(
            footer,
            style: const TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF18181B),
            ),
          ),
        ],
      ],
    );
  }
}
