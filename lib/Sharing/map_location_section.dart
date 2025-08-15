import 'dart:async'; // StreamSubscription 사용을 위해 추가
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:microstone_clothing_bin/Home/BottomIcon0.dart';
import 'package:http/http.dart' as http;
import 'package:microstone_clothing_bin/Home/marker_info.dart';

Future<List<marker_info>> fetchClothingBins() async {
  final response = await http.get(
    Uri.parse('https://marker-url.onrender.com/api/clothing-bins'),
  );
  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => marker_info.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load clothing bins');
  }
}

class MapLocationSection extends StatelessWidget {
  final VoidCallback? onLocationSelect;

  const MapLocationSection({Key? key, this.onLocationSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 24, left: 12),
          child: const Text(
            '의류수거함 위치',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF18181B),
            ),
          ),
        ),
        BottomIcon0(),
      ],
    );
  }
}
