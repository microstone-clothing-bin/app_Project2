import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:microstone_clothing_bin/join/join.dart';
import 'package:microstone_clothing_bin/join/Terms/terms_of_service_1.dart';
import 'package:microstone_clothing_bin/join/Terms/terms_of_service_2.dart';
import 'package:microstone_clothing_bin/join/Terms/terms_of_service_3.dart';

class CheckboxIcon extends StatelessWidget {
  final bool checked;
  final VoidCallback onChanged;
  final bool isLarge;

  const CheckboxIcon({
    super.key,
    required this.checked,
    required this.onChanged,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = isLarge ? 18.0 : 16.0;

    return GestureDetector(
      onTap: onChanged,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            // Circle outline
            CustomPaint(size: Size(size, size), painter: CirclePainter()),
            // Check mark
            if (checked)
              Positioned(
                left: isLarge ? 4.0 : 3.0,
                top: isLarge ? 4.0 : 3.0,
                child: CustomPaint(
                  size: Size(isLarge ? 11.0 : 9.0, isLarge ? 11.0 : 9.0),
                  painter: CheckPainter(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF9E9E9E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 0.5;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CheckPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF9E9E9E)
      ..style = PaintingStyle.fill;

    final path = Path();

    // Draw check mark path
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.4, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height * 0.3);

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TermsCheckbox extends StatelessWidget {
  final bool checked;
  final VoidCallback onChanged;
  final String title;
  final bool required;
  final bool showViewTerms;
  final VoidCallback? onViewTerms;
  final VoidCallback? onPressed;

  const TermsCheckbox({
    super.key,
    required this.checked,
    required this.onChanged,
    required this.title,
    this.required = false,
    this.showViewTerms = false,
    this.onViewTerms,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 500;
    final isMobile = screenWidth <= 390;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CheckboxIcon(checked: checked, onChanged: onChanged),
          const SizedBox(width: 24),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF18181B),
                    ),
                  ),
                ),
                if (required) ...[
                  const SizedBox(width: 8),
                  const Text(
                    '[필수]',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFA3A3A3),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showViewTerms) ...[
            const SizedBox(width: 8),
            TextButton(
              onPressed: onPressed ?? onViewTerms,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // 내부 여백 제거
                minimumSize: Size(0, 0), // 버튼 기본 최소 크기 제거
                tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 터치 영역 딱 맞게
                foregroundColor: const Color(0xFF6029B7), // 텍스트 색상 유지
              ),
              child: const Text(
                '약관보기 >',
                style: TextStyle(
                  fontSize: 12, // 기존과 동일
                  fontWeight: FontWeight.w500, // 기존과 동일
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class JoinForm extends StatefulWidget {
  const JoinForm({super.key});

  @override
  State<JoinForm> createState() => _JoinFormState();
}

class _JoinFormState extends State<JoinForm> {
  bool _allAgreed = false;
  bool _signupTerms = false;
  bool _privacyPolicy = false;
  bool _locationServices = false;
  bool _ageConfirmation = false;

  @override
  void initState() {
    super.initState();
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void _handleTermChange(String term) {
    setState(() {
      switch (term) {
        case 'signupTerms':
          _signupTerms = !_signupTerms;
          break;
        case 'privacyPolicy':
          _privacyPolicy = !_privacyPolicy;
          break;
        case 'locationServices':
          _locationServices = !_locationServices;
          break;
        case 'ageConfirmation':
          _ageConfirmation = !_ageConfirmation;
          break;
      }

      // Update allAgreed based on individual terms
      _allAgreed =
          _signupTerms &&
          _privacyPolicy &&
          _locationServices &&
          _ageConfirmation;
    });
  }

  void _handleAllAgreeChange() {
    setState(() {
      _allAgreed = !_allAgreed;
      _signupTerms = _allAgreed;
      _privacyPolicy = _allAgreed;
      _locationServices = _allAgreed;
      _ageConfirmation = _allAgreed;
    });
  }

  void _handleNextClick() {
    if (_isNextEnabled()) {
      // Handle next step
      print('Next button clicked');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
      );
    }
  }

  void _handleViewTerms(String termType) {
    print('View terms clicked for: $termType');
  }

  bool _isNextEnabled() {
    return _signupTerms &&
        _privacyPolicy &&
        _locationServices &&
        _ageConfirmation;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 500;
    final isMobile = screenWidth <= 390;

    final containerWidth = isMobile ? screenWidth : (isTablet ? 500.0 : 390.0);
    final containerHeight = screenHeight < 844 ? screenHeight : 844.0;

    void _handleBackClick() {
      Navigator.of(context).pop();
    }

    void _handleTerms1() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TermsOfService1()),
      );
    }

    void _handleTerms2() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TermsOfService2()),
      );
    }

    void _handleTerms3() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TermsOfService3()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: containerWidth,
          height: containerHeight,
          color: Colors.white,
          child: Stack(
            children: [
              // Header with back button and title
              Container(
                margin: const EdgeInsets.only(top: 32),
                constraints: const BoxConstraints(maxWidth: 216),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    Positioned(
                      left: 11,
                      child: GestureDetector(
                        onTap: _handleBackClick,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Transform.rotate(
                            angle: 1.5708, // 90 degrees in radians
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                              color: Color(0xFF6029B7),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Positioned(
                top: 208,
                left: isMobile
                    ? screenWidth * 0.08
                    : (isTablet ? screenWidth * 0.06 : 30),
                right: isMobile
                    ? screenWidth * 0.08
                    : (isTablet ? screenWidth * 0.06 : 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '이용약관에 동의해주세요.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF18181B),
                      ),
                    ),

                    const SizedBox(height: 64),

                    // All agree checkbox
                    Container(
                      padding: const EdgeInsets.only(bottom: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF3F4F6),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          CheckboxIcon(
                            checked: _allAgreed,
                            onChanged: _handleAllAgreeChange,
                            isLarge: true,
                          ),
                          const SizedBox(width: 24),
                          const Text(
                            '전체 동의합니다.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF18181B),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Individual terms
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        children: [
                          TermsCheckbox(
                            checked: _signupTerms,
                            onChanged: () => _handleTermChange('signupTerms'),
                            title: '회원가입 이용약관 동의',
                            required: true,
                            showViewTerms: true,
                            onViewTerms: () => _handleViewTerms('signup'),
                            onPressed: _handleTerms1,
                          ),

                          TermsCheckbox(
                            checked: _privacyPolicy,
                            onChanged: () => _handleTermChange('privacyPolicy'),
                            title: '개인정보 수집 및 이용 동의',
                            required: true,
                            showViewTerms: true,
                            onViewTerms: () => _handleViewTerms('privacy'),
                            onPressed: _handleTerms2,
                          ),

                          TermsCheckbox(
                            checked: _locationServices,
                            onChanged: () =>
                                _handleTermChange('locationServices'),
                            title: '위치기반 서비스 이용약관 동의',
                            required: true,
                            showViewTerms: true,
                            onViewTerms: () => _handleViewTerms('location'),
                            onPressed: _handleTerms3,
                          ),

                          TermsCheckbox(
                            checked: _ageConfirmation,
                            onChanged: () =>
                                _handleTermChange('ageConfirmation'),
                            title: '만 14세 이상입니다.',
                            required: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Next button
              Positioned(
                bottom: 62,
                left: isMobile
                    ? screenWidth * 0.08
                    : (isTablet ? screenWidth * 0.06 : 30),
                right: isMobile
                    ? screenWidth * 0.08
                    : (isTablet ? screenWidth * 0.06 : 30),
                child: GestureDetector(
                  onTap: _isNextEnabled() ? _handleNextClick : null,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: _isNextEnabled()
                          ? const Color(0xFF6029B7)
                          : const Color(0xFFD1D5DB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '다음으로',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
