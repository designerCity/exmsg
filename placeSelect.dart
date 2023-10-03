import 'package:exinstargram/upload.dart';
import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
// 카카오 맵 플러그인
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

const String kakaoMapKey = '9adddd89331245ea3191dadc3d71d38b';


class placeSelect extends StatefulWidget {
  // placeSelect({Key? key}) : super(key: key);
  placeSelect({super.key,
    // this.myLatLng,
    this.latitude,
    // this.longitude
  });
  final latitude;
  @override
  _placeSelectState createState() => _placeSelectState();
}

class _placeSelectState extends State<placeSelect> {


  String postCode = '-';
  String address = '-';
  LatLng myLatLng = LatLng(35.189994848066405, 126.82424155839115);

  String latitude = '35.189994848066405'; // 위도
  String longitude = '126.82424155839115'; // 경도
  String kakaoLatitude = '-';
  String kakaoLongitude = '-';

  late KakaoMapController mapController;
  late Marker marker;
  Set<Marker> markers = {}; // 마커 변수
  var message;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  // _addressAPI() async {
  //   KopoModel model = await Navigator.push(
  //     context,
  //     CupertinoPageRoute(
  //       builder: (context) => RemediKopo(),
  //     ),
  //   );
  //   _AddressController.text =
  //   '${model.zonecode!} ${model.address!} ${model.buildingName!}';
  // }

  void updateMapCenter(result) {

      setState(() {
        latitude = result.longitude.toString();
        longitude = result.latitude.toString();
        myLatLng = LatLng(33.189994848066405, 126.82424155839115);
      });
      // center 속성을 변경하여 KakaoMap 위젯을 다시 그리도록 합니다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('장소 위치 검색'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 50,
              child: TextButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => KpostalView(
                        // useLocalServer: true,
                        // localPort: 8081,
                        // kakaoKey: '9adddd89331245ea3191dadc3d71d38b',
                        // useKakaoGeocoder: true,// 이거 왜 안됨. // 카카오 API를 통해 경위도 좌표로 변환 사용
                        callback: (Kpostal result) {
                          print('그냥 주소 및 위경도');
                          print(result.address);
                          print(result.latitude.toString());
                          print(result.longitude.toString());
                          setState(() {
                            print(result);

                            // // kakao 위경도 객체은 Latlng
                            // var latlng = LatLng(double.parse(longitude), double.parse(latitude));
                            // mapController.setCenter(latlng);
                            print('카카오 위경도');
                            print(result.kakaoLatitude.toString());
                            // print('장덕동 1046');
                            // 장덕고등학교

                            // myLatLng = LatLng(double.parse(result.kakaoLatitude.toString()), double.parse(result.kakaoLongitude.toString()));
                            address = result.address;
                            latitude = result.latitude.toString();
                            longitude = result.longitude.toString();
                            myLatLng = LatLng(double.parse(latitude), double.parse(longitude));


                            markers.add(
                              Marker(
                                  markerId: markers.length.toString(),
                                  latLng: myLatLng,
                            )
                            );
                            mapController.setCenter(myLatLng);
                            setState(() {});
                          });
                          // updateMapCenter(result);// 주소 선택 후 지도 업데이트
                        },
                      ),
                    ),
                  );
                },
                child: Text('장소 검색하기'),
              ),
            ),
            // 위경도 주소 표시
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
              children: [
                Text('road_address : ${address}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
                Text('LatLng', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '위도 / latitude: ${this.latitude}'),
                Text(
                    '경도 / longitude: ${this.longitude}'),
                Text('through KAKAO Geocoder',
                  style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'latitude: ${this.kakaoLatitude} / longitude: ${this.kakaoLongitude}'),
                ],
              ),
            ),

            // kakaoMap 으로 위치 표현
            SizedBox(
              width: 500,
              height: 450,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child : KakaoMap(
                  // kakao map plugin 에서 맵을 클릭할 때 발생하는 이벤트
                  onMapTap: (latLng) {
                    markers.clear(); // 마커를 비우기
                    markers.add(Marker(
                      markerId: markers.length.toString(),
                      latLng: latLng,
                    ));

                    setState(() {});
                    print(latLng);
                  },
                  onMapCreated: ((controller) async {
                    mapController = controller;
                    markers.add(
                        Marker(
                          markerId: UniqueKey().toString(),
                          latLng: await mapController.getCenter(),
                        )
                    );
                    // updateMapCenter(latitude, longitude); // 초기 지도 업데이트
                    print('지도 그리기');
                    mapController.addMarker(markers: markers.toList());
                    await controller.keywordSearch();
                    setState(() {});
                  }),

                  // 마커의 정보를 보여줄 수 있게 만든다.
                  onMarkerTap: (markerId, latLng, zoomLevel) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('marker click event 위경도:\n\n$latLng')));
                  },

                  // 지도 스카와 스카이뷰 설정
                  mapTypeControl: true,
                  mapTypeControlPosition: ControlPosition.topRight,
                  zoomControl: true,
                  zoomControlPosition: ControlPosition.right,
                  // 맵 클릭 이벤트로 마커 등록하기
                  // onMapTap: ((latLng) {
                  //   marker.latLng = latLng;
                  //   mapController.panTo(latLng);
                  //   setState(() {});
                  // }),

                  currentLevel: 5,
                  markers: markers.toList(),
                  center: myLatLng, // 초기 중심 좌표

                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                onPressed: (){
                  Navigator.pop(context);
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context)
                  //       => Upload(
                  //           latitude: latitude,
                  //           longitude: longitude,
                  //       ),
                  //   ),
                  // );
               },
                child:
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text('해당 장소를 등록하기',
                      style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
