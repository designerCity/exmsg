import 'package:exinstargram/palceselect.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'main.dart';
import 'package:flutter/material.dart';
import 'palceselect.dart';

// kakao map plugin
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

// 사진 서버에 업로드하는 패키지
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'dart:io';

// typed_data -> Unit8List 를 다룰 때 사용
import 'dart:typed_data';
import 'dart:convert';

// 장소 등록 (upload) 페이지
class Upload extends StatefulWidget {
  Upload({super.key,
    this.userImage, this.userContent, this.setUserContent, this.data, this.addData,this.addMyData,
    // this.myLatLng, this.latitude, this.longitude
  });

  // 장소 변수 등록
  // final myLatLng;
  // final latitude;
  // final longitude;

  // 변수 등록
  final addData;
  final userImage;
  final userContent;
  final data;
  final addMyData;
  final setUserContent;

  @override
  State<Upload> createState() => UploadState();
}

class UploadState extends State<Upload> {
  // 위경도 placeselect.dart 에 보낼 것

  //  부모에서 관리하자
  String latitude = '35.189994848066405'; // 위도
  String longitude = '126.82424155839115'; // 경도

  TextEditingController inputController = TextEditingController();
  TextEditingController _controller1 = TextEditingController();

  String inputText = '';
  List<String> dropdownList = [
    '맛집',
    '공원',
    '벤치',
    '쓰레기통',
    '도서관',
    '박물관',
    '전시회',
    '카페'
  ];

  String selectedDropdown = '맛집';

  bool _isLabelVisible = true;
  var label = '등록하고자 하는 장소명을 입력해주세요';

  // 위도 / 경도 변환하는 함수
  // 이는 콜백 함수임.
  void transLatLng(String lat,String lng) {
    setState(() {
      latitude = lat;
      longitude = lng;
    });
  }

  // 별점을 부모에서 관리
  int rating = 0; // 부모 위젯에서 rating 변수를 관리

  @override
  void initState() {
    super.initState();
    //  InputController
    inputController.addListener(() {
      if (inputController.text.isNotEmpty) {
        setState(() {
          _isLabelVisible = false;
        });
      } else {
        setState(() {
          _isLabelVisible = true;
        });
      }
    });

  }

  String showFileName = "";
  // s3 에 보내기
  final List<PlatformFile> _files = [];
  // 파일을 업로드 하는 _pickFiles 함수
  void _pickFiles() async {
    List<PlatformFile>? uploadedFiles = (await FilePicker.platform.pickFiles(
      allowMultiple: true,
    ))
        ?.files;
    setState(() {
      for (PlatformFile file in uploadedFiles!) {
        _files.add(file);
      }
    });
    print(FilePicker.platform.pickFiles());
  }
  // S3 에 이미지 보내기
  Future<int> _uploadToSignedURL(
      {required PlatformFile file, required String url}) async {
    http.Response response = await http.put(Uri.parse(url), body: file.bytes);
    return response.statusCode;
  }

  // img file 서버로 보내기 (순수)
  var userImage;
  final ImagePicker picker = ImagePicker();

  PickedFile? _image; // 이미지 선택 전에 미리 선언
  Future uploadImage() async {
    if (_image != null) {
      print('${_image}');
      final uri = Uri.parse('UPLOAD_API_URL'); // 서버의 업로드 API URL로 변경
      final request = http.MultipartRequest('POST', uri);
      final bytes = await _image!.readAsBytes();
      print(bytes);
      request.files.add(
        http.MultipartFile.fromBytes(
          'file', // 서버에서 파일을 받을 필드 이름
          bytes,
          filename: 'image.jpg',
          contentType: MediaType('image', 'jpeg'), // 이미지 형식에 따라 변경
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        // 업로드 성공 시 처리
      } else {
        print('Image upload failed');
        // 업로드 실패 시 처리
      }
    }
  }

  XFile? _pickedFile;
  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = _pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('XFile : image is not selected 라고');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '장소 등록',
            textAlign: TextAlign.center, // 텍스트를 가운데 정렬합니다.
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // 등록한 게시물을 보여줄 수 있도록 widget. 으로 상속
                widget.addMyData();
                XFile? image = await ImagePicker().pickImage(
                    source: ImageSource.gallery, // 위치 : 갤러리
                    maxHeight: 75,
                    maxWidth: 75,
                    imageQuality: 30,
                );
                if (image != null) {
                  setState((){
                    userImage = File(image.path);
                  });
                }
                uploadImage();         // server 에 이미지 업로드
                Navigator.pop(context);
              },
              icon: Icon(Icons.send))
          ]
      ),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0), // 원하는 깍임 정도를 설정합니다.
            ),
            child: Center(
              child: Container(
                height: 50,
                child: TextFormField(
                  onTap: () {
                    if (_isLabelVisible) {
                      setState(() {
                        _isLabelVisible = false;
                      });
                    }
                  },
                  controller: inputController,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "장소명을 입력해주세요";
                    }
                    return null;
                  },

                  style: TextStyle(
                      color: Colors.green,
                      decorationColor: Colors.red,
                      fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),

                  decoration: InputDecoration(
                    // labelText: '등록하고자 하는 장소명을 입력해주세요',
                    labelStyle: TextStyle(color: Colors.green),
                    labelText: _isLabelVisible ? label : '',

                    fillColor: Colors.green,
                    prefixIcon: Icon(Icons.place, color: Colors.green,),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      color: Colors.green,
                      onPressed: (){
                        inputController.clear();

                        if (!_isLabelVisible) {
                          setState(() {
                            _isLabelVisible = true;
                            label = '등록하고자 하는 장소명을 입력해주세요';
                          });
                        }
                      },
                    ),
                    // hintText: '등록하고자 하는 장소명을 입력해주세요',
                    // hintStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.green, // 원하는 색상으로 변경
                      ),
                    ),
                    // prefixText: 'PrefixText',
                    // suffixText: 'Suffixtext',
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   height: 20,
          //   color: Colors.green,
          //   child: InkWell(
          //     child: Container(
          //       color: Colors.green,
          //     ),
          //     //
          //     onTap: () async {
          //       FilePickerResult? result = await FilePicker.platform.pickFiles(
          //         type: FileType.custom,
          //         allowedExtensions: ['csv', 'svg', 'pdf', 'png'],
          //       );
          //       if( result != null && result.files.isNotEmpty ){
          //         String fileName = result.files.first.name;
          //
          //         debugPrint(fileName);
          //         setState(() {
          //           showFileName = "Now File Name: $fileName";
          //         });
          //       }
          //     },
          //   ),
          // ), // 사진이나 파일(csv, svg, pdf,, png)
          Center(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 250,
                    // margin: EdgeInsets.only(left: 20, right: 20),
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton.icon(
                      onPressed:(){
                        // 클릭 시 이동
                        Navigator.push(
                          context,
                          // MaterialPageRoute(builder: (context) => settingPage(sendMessege: sendMessege, responseData: responseData)),
                          MaterialPageRoute(builder: (context) => placeSelect(transLatLng: transLatLng,latitude: latitude, longitude: longitude,)),
                        );
                      },
                      icon: Icon(Icons.search), // 돋보기 아이콘
                      label: Text('장소 위치 검색 버튼', style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ), // 버튼 레이블
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color.fromRGBO(51, 51, 51, 0.8),
                        backgroundColor: Color.fromRGBO(51, 51, 51, 0.13), // 버튼 텍스트 색상
                        padding: EdgeInsets.all(5), // 버튼 내부 패딩
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), // 버튼 모서리 둥글기
                        ),
                      ),
                    ),
                  ),
                  // 카테고리 고르는 버튼
                  DropdownButton(
                    value: selectedDropdown,
                    items: dropdownList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          '$item',
                          style: TextStyle(
                              fontSize: 15, // 폰트 크기 조절
                              fontWeight: FontWeight.bold,
                              color: Colors.green
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectedDropdown = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ), // 장소 카테고리 버튼
          // 아래는 장소 주소를 통한 위경도 검색 버튼


          Container(
              margin: EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.file(
                widget.userImage,
                width: 400.0, // 이미지의 최대 너비
                height: 300.0, // 이미지의 최대 높이
                fit: BoxFit.cover, // 이미지를 최대 크기에 맞추고 자르기
              ),
            ),
          ), // 유저가 선택한 이미지
          // 별점
          Center(
            child: Column(
              children: [
                // 말풍선
                Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      // border: Border.all(
                      //   color: Colors.red, // 원하는 선 색상을 설정합니다.
                      //   width: 2.0, // 선의 두께를 설정합니다.
                      // ),
                      borderRadius: BorderRadius.circular(20.0), // 원하는 깍임 정도를 설정합니다.
                    ),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5, bottom: 5), // 원하는 패딩 값을 설정합니다.
                    margin: EdgeInsets.only(top: 0),
                    child: Text(
                      '별점과 후기 작성하고 마일리지를 획득하세요',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0, // 원하는 폰트 크기로 설정
                        fontWeight: FontWeight.bold, // 원하는 폰트 두께로 설정 (normal, bold 등)
                      ),
                    )
                ),
                Center(
                  child: CustomPaint(
                    size: Size(10, 10), // 역삼각형의 크기 설정
                    painter: TrianglePainter(),
                  ),
                ),
                StarRating(
                  rating: rating, // _StarRating 위젯에 rating 변수 전달
                  onRatingChanged: (newRating) {
                    setState(() {
                      rating = newRating; // _StarRating 위젯에서 rating 값 변경
                      print('장소 별점 $rating');
                    });
                  },
                ),
              ],
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('$inputText'),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                      child: TextField(
                        controller: _controller1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 50.0), // 여기에서 높이 조절

                          labelText: '  Review',
                          hintText: '해당 장소에 대한 리뷰를 작성해주세요',
                          labelStyle: TextStyle(color: Colors.green),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.green),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Colors.green),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        // 키보드 타입 설정
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 장소 등록 버튼 구현
          Center(
            child: Container(
              width: 500,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // getImage();
                      uploadImage();
                      Navigator.pop(context);
                      // btn click 시 POST 요청 보내기
                      // print({
                      //   '장소명' : '${inputController.text}',
                      //   'review': '${_controller1.text}' ,
                      //   'category' :'$selectedDropdown',
                      //   'img': '${widget.userImage}',
                      //   '별점': '${rating}',
                      //   'latitude':  latitude,
                      //   'longitude':  longitude,
                      // });
                    },
                    child: Text('XFIle 으로 서버에 올리기 test', style: TextStyle(fontSize: 20, color: Colors.black),),
                  ),
                  TextButton(
                    onPressed: () {
                      // _pickFiles();
                      // _uploadToSignedURL(file: userImage, url: '여기에 url')

                      Navigator.pop(context);
                      // btn click 시 POST 요청 보내기
                    },
                    child: Text('S3 에 바로 업로드', style: TextStyle(fontSize: 20),),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
// 별점 등록하는 위젯
class StarRating extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingChanged;

  StarRating({required this.rating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            onTap: () {
              // 별점을 선택한 경우 부모 위젯으로 콜백 호출하여 rating 값을 업데이트
              onRatingChanged(i);
            },
            child: Icon(
              i <= rating ? Icons.star : Icons.star_border,
              size: 40.0,
              color: Colors.amberAccent,
            ),
          ),
      ],
    );
  }
}
// 말충선 꾸미기
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green // 역삼각형의 색상
      ..style = PaintingStyle.fill; // 역삼각형 내부를 채우도록 설정

    final path = Path()
      ..moveTo(size.width / 2, size.height) // 시작점 (화면 아래쪽 중앙)
      ..lineTo(0, 0) // 왼쪽 위로 선 긋기
      ..lineTo(size.width, 0) // 오른쪽 위로 선 긋기
      ..close(); // 경로 닫기

    canvas.drawPath(path, paint); // 캔버스에 역삼각형 그리기
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // 업데이트가 필요하지 않음
  }
}



