import 'package:flutter/material.dart';

class ValidationRequirement {
  final String label;
  final bool isValid;
  final String icon;

  ValidationRequirement({
    required this.label,
    required this.isValid,
    required this.icon,
  });
}

class ValidationRequirements extends StatelessWidget {
  final String password;

  const ValidationRequirements({Key? key, required this.password})
    : super(key: key);

  List<ValidationRequirement> _getRequirements() {
    return [
      ValidationRequirement(
        label: "영문 대/소문자",
        isValid: RegExp(r'[a-zA-Z]').hasMatch(password),
        icon:
            "https://api.builder.io/api/v1/image/assets/TEMP/aebfcdff0f8eff3b5eb7dc113e8882977e37d1ba?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94",
      ),
      ValidationRequirement(
        label: "숫자",
        isValid: RegExp(r'\d').hasMatch(password),
        icon:
            "https://api.builder.io/api/v1/image/assets/TEMP/7ac9c20102ab05cd87ab6766998d35c57c7102aa?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94",
      ),
      ValidationRequirement(
        label: "특수문자",
        isValid: RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password),
        icon:
            "https://api.builder.io/api/v1/image/assets/TEMP/fc19a1eca4791833c73b7f52e9d5d77820fe2121?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94",
      ),
      ValidationRequirement(
        label: "8~20자",
        isValid: password.length >= 8 && password.length <= 20,
        icon:
            "https://api.builder.io/api/v1/image/assets/TEMP/ce4efdcacb0b33e481e3ebc107bc3ad045d8c4ae?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final requirements = _getRequirements();

    return Container(
      width: 313,
      margin: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: requirements.map((requirement) {
          return Row(
            children: [
              Opacity(
                opacity: requirement.isValid ? 1.0 : 0.5,
                child: Container(
                  width: 10,
                  height: 10,
                  child: Image.network(requirement.icon, fit: BoxFit.contain),
                ),
              ),
              SizedBox(width: 4),
              Text(
                requirement.label,
                style: TextStyle(
                  fontSize: 12,
                  color: requirement.isValid
                      ? Color(0xFF16A34A)
                      : Color(0xFFA3A3A3),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
