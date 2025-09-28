import 'package:flutter/material.dart';
import 'dart:io';
import 'photo_upload_section.dart';
import 'form_input.dart';
import 'form_textarea.dart';
import 'map_location_section.dart';
import 'submit_button.dart';
import 'package:microstone_clothing_bin/config/mySQLConnector.dart'; // ✅ BoardService import

class SharingPostForm extends StatefulWidget {
  const SharingPostForm({Key? key}) : super(key: key);

  @override
  State<SharingPostForm> createState() => _SharingPostFormState();
}

class _SharingPostFormState extends State<SharingPostForm> {
  String title = '';
  String description = '';
  String photoPath = '';
  String address = '';

  void handleTitleChange(String value) {
    setState(() {
      title = value;
    });
  }

  void handleDescriptionChange(String value) {
    setState(() {
      description = value;
    });
  }

  void handlePhotoSelect(File file) {
    setState(() {
      photoPath = file.path; // ✅ 사진 경로 저장
    });
    print('Photo selected: $photoPath');
  }

  void handleLocationSelect(String selectedAddress) {
    setState(() {
      address = selectedAddress; // ✅ 마커 선택 시 주소 저장
    });
    print('Address selected: $address');
  }

  Future<void> handleSubmit() async {
    if (!isFormValid) return;

    try {
      final board = Board(
        id: 0, // 서버에서 자동 생성
        photo: photoPath,
        title: title,
        content: description,
        address: address,
      );

      final result = await BoardService().createBoard(board);
      print("게시글 작성 성공: ${result.toJson()}");

      // 작성 완료 후 알림
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("게시글이 성공적으로 등록되었습니다.")));

      // 작성 후 초기화
      setState(() {
        title = '';
        description = '';
        photoPath = '';
        address = '';
      });
    } catch (e) {
      print("게시글 작성 실패: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("게시글 등록 실패: $e")));
    }
  }

  bool get isFormValid {
    return title.trim().isNotEmpty &&
        description.trim().isNotEmpty &&
        address.trim().isNotEmpty &&
        photoPath.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PhotoUploadSection(onPhotoSelect: handlePhotoSelect),
                        FormInput(
                          label: '제목',
                          placeholder: '글 제목',
                          value: title,
                          onChange: handleTitleChange,
                        ),
                        FormTextarea(
                          label: '자세한 설명',
                          placeholder: '나눔할 물품에 대한 게시글 내용을 작성해주세요.',
                          value: description,
                          onChange: handleDescriptionChange,
                        ),
                        // 지도 → 마커 클릭 시 handleLocationSelect 실행되도록 수정
                        MapLocationSection(
                          onLocationSelect: handleLocationSelect,
                        ),
                        SubmitButton(
                          onClick: handleSubmit,
                          disabled: !isFormValid,
                        ),
                      ],
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
