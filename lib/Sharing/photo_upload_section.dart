import 'package:flutter/material.dart';
import 'dart:io';

class PhotoUploadSection extends StatelessWidget {
  final Function(File)? onPhotoSelect;

  const PhotoUploadSection({Key? key, this.onPhotoSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleBackClick() {
      Navigator.of(context).pop();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 12, left: 12),
          child: const Text(
            '사진 등록',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF18181B),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8, left: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              'https://api.builder.io/api/v1/image/assets/TEMP/afbb02041c3d75abeb9b34b6537847d24d4d9315?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94',
              width: 68,
              height: 48,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
