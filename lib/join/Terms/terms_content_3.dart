//위치정보 동의서 내용1

import 'package:flutter/material.dart';

class TermsContent3 extends StatelessWidget {
  const TermsContent3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            title: '제1조 (목적)',
            content:
                '이 약관은 [Drop It(드랍잇)] (이하 "회사")이 제공하는 위치기반 서비스와 관련하여 회사와 회원 간의 권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다.',
          ),
          const SizedBox(height: 16),
          _buildSectionWithList(
            title: '제2조 (위치정보의 수집 및 이용)',
            items: [
              '회사는 회원에게 맞춤형 서비스를 제공하기 위해 회원의 위치정보를 수집 및 이용할 수 있습니다.',
              '수집하는 위치정보는 모바일 기기, 웹 브라우저, GPS 등 다양한 기술을 통해 수집될 수 있습니다.',
              '위치정보는 다음과 같은 목적에 활용됩니다.',
            ],
            subItems: ['가까운 의류수거함 위치 안내', '위치 기반 통계 및 서비스 개선', '사용자 맞춤 정보 제공'],
          ),
          const SizedBox(height: 16),
          _buildSectionWithList(
            title: '제3조 (위치정보 수집 방법 및 보유 기간)',
            items: [
              '위치정보는 서비스 이용 시점에 한하여 실시간으로 수집되며, 별도로 저장되지 않습니다.',
              '실시간 기능 외에 저장이 필요한 경우, 사전 동의를 받은 후 필요한 범위 내에서만 저장합니다.',
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionWithList(
            title: '제4조 (이용자의 권리)',
            items: [
              '이용자는 언제든지 위치정보 제공을 거부하거나 동의 철회를 요청할 수 있습니다.',
              '위치정보 제공 거부 시, 일부 위치기반 서비스 이용이 제한될 수 있습니다.',
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionWithList(
            title: '제5조 (개인위치정보의 제3자 제공)',
            items: [
              '회사는 이용자의 동의 없이 개인위치정보를 제3자에게 제공하지 않습니다.',
              '개인위치정보를 제3자에게 제공할 경우, 제공받는 자, 제공 목적 및 제공 항목을 사전에 명확히 고지하고 동의를 받습니다.',
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            title: '제6조 (책임의 제한)',
            content:
                '회사는 위치정보 제공이 불가능하거나 부정확한 경우라도, 회사의 고의 또는 중대한 과실이 없는 한 책임을 지지 않습니다.',
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionWithList({
    required String title,
    required List<String> items,
    List<String>? subItems,
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
          ),
        ),
        const SizedBox(height: 4),
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          String item = entry.value;
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. ',
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        if (subItems != null) ...[
          ...subItems
              .map(
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
                        ),
                      ),
                      Expanded(
                        child: Text(
                          subItem,
                          style: const TextStyle(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ],
    );
  }
}
