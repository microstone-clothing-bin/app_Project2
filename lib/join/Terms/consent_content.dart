//위치정보 동의서 내용2

import 'package:flutter/material.dart';

class ConsentContent extends StatelessWidget {
  const ConsentContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '회사는 위치기반 서비스를 제공하기 위해 아래와 같은 위치정보를 수집·이용하며, 본인은 이에 동의합니다.',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          _buildConsentSection(
            title: '수집 항목',
            items: ['실시간 위치정보 (GPS 또는 IP 기반)'],
          ),
          const SizedBox(height: 12),
          _buildConsentSection(
            title: '수집 목적',
            items: ['주변 의류수거함 안내 등 위치기반 서비스 제공'],
          ),
          const SizedBox(height: 12),
          _buildConsentSection(
            title: '보유 및 이용 기간',
            items: [
              '실시간 활용 후 즉시 폐기',
              '단, 동의 하에 저장되는 정보는 보관 목적에 따라 별도 고지된 기간 동안 보관',
            ],
          ),
          const SizedBox(height: 12),
          _buildConsentSection(
            title: '동의 거부 권리 및 불이익',
            items: ['이용자는 위치정보 제공을 거부할 수 있으나, 이 경우 관련 서비스 이용이 제한될 수 있습니다.'],
          ),
          const SizedBox(height: 16),
          const Text(
            '본인은 위 내용을 충분히 이해하였으며, 위치기반 서비스 이용에 동의합니다.',
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsentSection({
    required String title,
    required List<String> items,
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
        ...items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 4),
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
              ),
            )
            .toList(),
      ],
    );
  }
}
