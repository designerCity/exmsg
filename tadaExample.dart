import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0;
  double longitude = 0;

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    // print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}

void requestFullAccuracyPermission() async {
  try {
    await Geolocator.requestTemporaryFullAccuracy(purposeKey: "YourPurposeKey");
    // 위치 액세스 권한이 부여되었고 임시 전체 정확도 액세스 권한을 얻었습니다.
    // 이제 위치 데이터를 더 정확하게 얻을 수 있습니다.
  } catch (e) {
    // 권한 요청 실패 또는 오류 처리
  }
}

class kakaoMap extends StatefulWidget {
  const kakaoMap({super.key});

  @override
  State<kakaoMap> createState() => _kakaoMapState();
}

class _kakaoMapState extends State<kakaoMap> {

  Set<Marker> markers = {}; // 마커 변수
  var mapController;
  var message;
  // 카카오 맵에서 장소 검색 기능
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  void getLocation() async{

    Position position = await Geolocator.
    getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  void initState(){
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Stack(
                  children: [
                    Column(
                      children: [
                        // kakao map
                        Expanded(child: KakaoMap(
                          onMapCreated: ((controller) async {
                          mapController = controller;

                          markers.add(Marker(
                            markerId: UniqueKey().toString(),
                            latLng: await mapController.getCenter(),
                          ));

                          setState(() {
                            // print(message);
                            });
                          }),
                          markers: markers.toList(),
                          center: LatLng(35.189994848066405, 126.82424155839115)
                          ),
                        )
                      ],
                    ),
                    Type2(), // 위의 목적지에서 출발지
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)
                          )
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: 60,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8)
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                backgroundColor: Colors.white,
                expandedHeight: 450,
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Column(
                          children: [
                            Type4(),
                          ],
                        );
                      },
                    childCount: 1,
                )
              )
            ],
          )
        ),
        Type3()
      ],
    );
    // return Scaffold(
    //   body: KakaoMap(
    //       onMapCreated: ((controller) async {
    //         mapController = controller;
    //
    //         markers.add(Marker(
    //           markerId: UniqueKey().toString(),
    //           latLng: await mapController.getCenter(),
    //         ));
    //
    //         setState(() {
    //           // print(message);
    //         });
    //       }),
    //       markers: markers.toList(),
    //       center: LatLng(35.189994848066405, 126.82424155839115)
    //   ),
    //
    // );
  }
}

class Type2 extends StatefulWidget {
  const Type2({Key? key}) : super(key: key);

  @override
  State<Type2> createState() => _Type2State();
}

class _Type2State extends State<Type2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // 뒤로가기 버튼 누르면 pop
                  // 샘플 앱에서는 쌓여있는 위젯이 없어 아래와 같이 코드를 넣으면
                  // 검정색 화면만 나오게 됨
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_ios, size: 18),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(child: Text('강남역[2호선]', textAlign: TextAlign.center)),
                    Icon(Icons.arrow_right_alt),
                    Expanded(child: Text('남산서울타워', textAlign: TextAlign.center)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Type3 extends StatefulWidget {
  const Type3({Key? key}) : super(key: key);

  @override
  State<Type3> createState() => _Type3State();
}

class _Type3State extends State<Type3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: subItem(Icons.card_membership, '결제수단', '카카오뱅크 **8354 개인')),
              Container(
                width: 1,
                height: 24,
                color: Colors.grey.withOpacity(0.2),
              ),
              Expanded(child: subItem(Icons.airplane_ticket_rounded, '쿠폰 / 크레딧', '할인 적용됨')),
            ],
          ),

          /// 버튼
          Ink(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF1B264A),
              borderRadius: BorderRadius.circular(4),
            ),
            child: InkWell(
              onTap: () {
                // 버튼 클릭 이벤트
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Text(
                  '넥스트 선택',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 결제수단 , 쿠폰/크레딧 구현을 위한 공통 위젯
  Widget subItem(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 16),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_right_outlined, size: 14)
            ],
          ),
          const SizedBox(height: 8),
          Text(content)
        ],
      ),
    );
  }
}
class Type4 extends StatefulWidget {
  const Type4({Key? key}) : super(key: key);

  @override
  State<Type4> createState() => _Type4State();
}

class _Type4State extends State<Type4> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        subItem(),
        subItem(),
        subItem(),
        subItem(),
        subItem(),
      ],
    );
  }

  Widget subItem() {
    return InkWell(
      onTap: () {
        debugPrint('***** [JHC_DEBUG] 선택');
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
            ), // 좌측 차량 이미지
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text('넥스트', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.person, size: 14),
                        SizedBox(width: 4),
                        Text('5', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.info_outline, size: 14),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '대형 RV의 쾌적한 이동',
                      style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                    ),
                  ],
                ),
              ),
            ), // 중간 차량 타입
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_upward, size: 12, color: Colors.grey.withOpacity(0.8)),
                    Text('2.0배', style: TextStyle(fontSize: 12, color: Colors.grey.withOpacity(0.8))),
                  ],
                ),
                const SizedBox(height: 2),
                const Text('예상 17,200원', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 2),
                Text(
                  '예상 23,200원',
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 14,
                    color: Colors.grey.withOpacity(0.8),
                  ),
                ),
              ],
            ) // 오른쪽의 요금
          ],
        ),
      ),
    );
  }
}
