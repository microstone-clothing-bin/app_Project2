import 'package:flutter/material.dart';
import 'dart:io';
import 'photo_upload_section.dart';
import 'form_input.dart';
import 'form_textarea.dart';
import 'map_location_section.dart';
import 'submit_button.dart';
import 'package:microstone_clothing_bin/main.dart';

class SharingPostForm extends StatefulWidget {
  const SharingPostForm({Key? key}) : super(key: key);

  @override
  State<SharingPostForm> createState() => _SharingPostFormState();
}

class _SharingPostFormState extends State<SharingPostForm> {
  String title = '';
  String description = '';

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
    print('Photo selected: ${file.path}');
  }

  void handleLocationSelect() {
    print('Location selection requested');
  }

  void handleSubmit() {
    print('Form submitted - Title: $title, Description: $description');
  }

  bool get isFormValid {
    return title.trim().isNotEmpty && description.trim().isNotEmpty;
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
                        //지도
                        MapLocationSection(
                          onLocationSelect: handleLocationSelect,
                        ),
                        SubmitButton(
                          onClick: handleSubmit,
                          disabled: !isFormValid,
                        ),
                        SuccessScreen(),
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
