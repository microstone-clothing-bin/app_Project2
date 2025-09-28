//회원가입 동의서 내용

import 'package:flutter/material.dart';

class TermsContent1 extends StatelessWidget {
  const TermsContent1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 32, left: 20),
      padding: EdgeInsets.symmetric(vertical: 2),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '회원가입 이용약관',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF18181B), // zinc-900
            ),
          ),
          SizedBox(height: 14),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: '제1조 (목적)',
                  content:
                      '이 약관은 [Drop it(드랍잇)] (이하 "회사")가 제공하는 서비스의 이용과 관련하여 회사와 회원 간의 권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다.',
                ),
                SizedBox(height: 16),
                _buildSectionWithList(
                  title: '제2조 (용어의 정의)',
                  items: [
                    '"회원"이란 회사에 개인정보를 제공하여 회원등록을 한 자로서, 회사의 서비스를 지속적으로 이용할 수 있는 자를 말합니다.',
                    '"아이디(ID)"란 회원의 식별과 서비스 이용을 위하여 회원이 설정하고 회사가 승인하는 문자와 숫자의 조합을 말합니다.',
                    '"비밀번호"란 회원이 설정한 아이디와 일치하는지 확인하고 회원의 개인정보 보호를 위해 설정한 문자와 숫자의 조합을 말합니다.',
                    '"닉네임"이란 서비스 내에서 회원을 식별하기 위해 사용되는 별칭입니다.',
                    '"이메일"이란 회사가 회원에게 고지사항 및 서비스 안내 등을 제공하기 위해 수집하는 전자우편 주소를 말합니다.',
                  ],
                ),
                SizedBox(height: 16),
                _buildSectionWithList(
                  title: '제3조 (약관의 효력 및 변경)',
                  items: [
                    '이 약관은 서비스를 이용하고자 하는 모든 이용자에게 그 효력이 발생합니다.',
                    '회사는 필요 시 약관을 변경할 수 있으며, 변경 시 공지사항을 통해 사전 고지합니다.',
                    '변경된 약관에 동의하지 않을 경우 회원은 탈퇴할 수 있으며, 별도의 이의 제기 없이 서비스를 계속 이용할 경우 변경 약관에 동의한 것으로 간주합니다.',
                  ],
                ),
                SizedBox(height: 16),
                _buildComplexSection(),
                SizedBox(height: 16),
                _buildSectionWithList(
                  title: '제5조 (회원의 의무)',
                  items: [
                    '회원은 본 약관 및 회사의 공지사항, 관련 법령을 준수해야 합니다.',
                    '회원은 타인의 정보를 도용하거나, 허위 정보를 제공해서는 안 됩니다.',
                    '회원은 서비스 이용과 관련하여 회사의 명예를 훼손하거나 운영을 방해하는 행위를 하여서는 안 됩니다.',
                  ],
                ),
                SizedBox(height: 16),
                _buildSectionWithSubList(
                  title: '제6조 (회원 탈퇴 및 자격 상실)',
                  items: [
                    '회원은 언제든지 회원 탈퇴를 요청할 수 있으며, 회사는 즉시 회원 탈퇴를 처리합니다.',
                    '다음 각 호에 해당하는 경우, 회사는 사전 통지 없이 회원 자격을 제한 또는 박탈할 수 있습니다.',
                  ],
                  subItems: [
                    '가입 시 허위 정보를 입력한 경우',
                    '타인의 서비스 이용을 방해하거나 정보를 도용한 경우',
                    '기타 본 약관에 위반되는 행위를 한 경우',
                  ],
                ),
              ],
            ),
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
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF18181B),
            fontFamily: 'Pretendard',
          ),
        ),
        SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF18181B),
            fontFamily: 'Pretendard',
          ),
        ),
      ],
    );
  }

  Widget _buildSectionWithList({
    required String title,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF18181B),
            fontFamily: 'Pretendard',
          ),
        ),
        SizedBox(height: 4),
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          String item = entry.value;
          return Padding(
            padding: EdgeInsets.only(left: 16, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${index + 1}. ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF18181B),
                    fontFamily: 'Pretendard',
                  ),
                ),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF18181B),
                      fontFamily: 'Pretendard',
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildComplexSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '제4조 (회원가입 및 정보 수집)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF18181B),
            fontFamily: 'Pretendard',
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1. ', style: _getBodyTextStyle()),
                  Expanded(
                    child: Text(
                      '회원가입은 본 약관에 동의하고, 회사가 요청하는 필수 정보를 정확히 입력하여 신청한 후 회사가 이를 승낙함으로써 성립됩니다.',
                      style: _getBodyTextStyle(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('2. ', style: _getBodyTextStyle()),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '회원이 가입 시 회사가 수집하는 정보는 다음과 같습니다.',
                          style: _getBodyTextStyle(),
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• 아이디 (필수)', style: _getBodyTextStyle()),
                              Text('• 비밀번호 (필수)', style: _getBodyTextStyle()),
                              Text('• 닉네임 (필수)', style: _getBodyTextStyle()),
                              Text('• 이메일 (필수)', style: _getBodyTextStyle()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('3. ', style: _getBodyTextStyle()),
                  Expanded(
                    child: Text(
                      '회사는 회원의 동의 없이 개인정보를 제3자에게 제공하지 않으며, 수집 목적 외의 용도로 사용하지 않습니다. 자세한 사항은 \'개인정보처리방침\'을 따릅니다.',
                      style: _getBodyTextStyle(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionWithSubList({
    required String title,
    required List<String> items,
    required List<String> subItems,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF18181B),
            fontFamily: 'Pretendard',
          ),
        ),
        SizedBox(height: 4),
        ...items.asMap().entries.map((entry) {
          int index = entry.key;
          String item = entry.value;
          return Padding(
            padding: EdgeInsets.only(left: 16, bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${index + 1}. ', style: _getBodyTextStyle()),
                Expanded(child: Text(item, style: _getBodyTextStyle())),
              ],
            ),
          );
        }).toList(),
        if (subItems.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subItems.map((subItem) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: _getBodyTextStyle()),
                      Expanded(
                        child: Text(subItem, style: _getBodyTextStyle()),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  TextStyle _getBodyTextStyle() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color(0xFF18181B),
      fontFamily: 'Pretendard',
    );
  }
}
