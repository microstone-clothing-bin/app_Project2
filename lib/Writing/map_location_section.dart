// lib/Sharing/map_location_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // ✅ 주소 변환용 패키지 추가

class MapLocationSection extends StatefulWidget {
  final ValueChanged<String>? onLocationSelect; // ✅ 주소 전달 콜백
  final double? latitude;
  final double? longitude;
  final bool interactive;
  final double heightFraction;

  const MapLocationSection({
    Key? key,
    this.onLocationSelect,
    this.latitude,
    this.longitude,
    this.interactive = false,
    this.heightFraction = 0.25,
  }) : super(key: key);

  @override
  State<MapLocationSection> createState() => _MapLocationSectionState();
}

class _MapLocationSectionState extends State<MapLocationSection> {
  NaverMapController? _controller;
  NLatLng? _center;
  bool _loading = true;
  bool _markerAdded = false;

  @override
  void initState() {
    super.initState();
    if (widget.latitude != null && widget.longitude != null) {
      _center = NLatLng(widget.latitude!, widget.longitude!);
      _loading = false;
    } else {
      _initCurrentLocation();
    }
  }

  Future<void> _initCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception('Location services disabled');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied');
      }

      final pos = await Geolocator.getCurrentPosition();
      setState(() {
        _center = NLatLng(pos.latitude, pos.longitude);
        _loading = false;
      });
      _maybeUpdateMap();
    } catch (_) {
      // 폴백: 서울 시청
      setState(() {
        _center = NLatLng(37.5666, 126.9784);
        _loading = false;
      });
      _maybeUpdateMap();
    }
  }

  void _maybeUpdateMap() {
    if (_controller != null && _center != null && !_markerAdded) {
      final marker = NMarker(id: 'mini-map-marker', position: _center!);
      _controller!.addOverlay(marker);

      // ✅ 마커 클릭 이벤트 → 좌표를 주소로 변환 후 콜백 실행
      marker.setOnTapListener((overlay) async {
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            marker.position.latitude,
            marker.position.longitude,
            localeIdentifier: "ko_KR", // 한국어 주소
          );

          if (placemarks.isNotEmpty) {
            final place = placemarks.first;
            final address =
                "${place.administrativeArea ?? ''} ${place.locality ?? ''} ${place.street ?? ''}"
                    .trim();

            if (widget.onLocationSelect != null) {
              widget.onLocationSelect!(address); // ✅ 주소 전달
            }
          }
        } catch (e) {
          debugPrint("주소 변환 실패: $e");
        }
      });

      _controller!.updateCamera(
        NCameraUpdate.fromCameraPosition(
          NCameraPosition(target: _center!, zoom: 15),
        ),
      );
      _markerAdded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    const double minHeight = 140;
    const double maxHeight = 360;
    final double mapHeight = (size.height * widget.heightFraction)
        .clamp(minHeight, maxHeight)
        .toDouble();

    final double mapWidth = size.width - 24;

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
        Container(
          margin: const EdgeInsets.only(top: 8, left: 12, right: 12),
          width: mapWidth,
          height: mapHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _loading || _center == null
                ? const _MiniMapLoading()
                : NaverMap(
                    options: NaverMapViewOptions(
                      initialCameraPosition: NCameraPosition(
                        target: _center!,
                        zoom: 15,
                      ),
                      scrollGesturesEnable: widget.interactive,
                      zoomGesturesEnable: widget.interactive,
                      rotationGesturesEnable: widget.interactive,
                      tiltGesturesEnable: widget.interactive,
                      indoorEnable: false,
                      locationButtonEnable: false,
                    ),
                    onMapReady: (controller) {
                      _controller = controller;
                      _maybeUpdateMap();
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class _MiniMapLoading extends StatelessWidget {
  const _MiniMapLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F4F5),
      alignment: Alignment.center,
      child: const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
