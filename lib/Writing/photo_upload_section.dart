import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PhotoUploadSection extends StatefulWidget {
  final Function(File)? onPhotoSelect;

  const PhotoUploadSection({Key? key, this.onPhotoSelect}) : super(key: key);

  @override
  State<PhotoUploadSection> createState() => _PhotoUploadSectionState();
}

class _PhotoUploadSectionState extends State<PhotoUploadSection> {
  File? _selectedPhoto;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    ); // 갤러리에서 선택

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      setState(() {
        _selectedPhoto = file;
      });

      // 부모 위젯에 전달
      if (widget.onPhotoSelect != null) {
        widget.onPhotoSelect!(file);
      }
    }
  }

  void _handleBackClick() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
              GestureDetector(
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
          child: GestureDetector(
            onTap: _pickImage, // 클릭 시 갤러리 열기
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: _selectedPhoto != null
                  ? Image.file(
                      _selectedPhoto!,
                      width: 68,
                      height: 48,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      'https://api.builder.io/api/v1/image/assets/TEMP/afbb02041c3d75abeb9b34b6537847d24d4d9315?placeholderIfAbsent=true&apiKey=2e52a8c4d23d4dad82ddd51e30f98c94',
                      width: 68,
                      height: 48,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
