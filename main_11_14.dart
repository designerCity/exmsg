Scaffold(
      // floatingActionButton: FloatingActionButton(child: Text('+'), onPressed: (){
      //   showNotification2();
      // },),
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize, // 기본 AppBar 크기 사용
        child: SafeArea(
          child: AppBar(
            leading: IconButton(icon: Icon(Icons.menu), onPressed: (){
              Navigator.push(context,
                  PageRouteBuilder(pageBuilder: (c, a1, a2 ) => Menu(),
                      transitionsBuilder:(c, a1, a2, child) =>
                      // 애니매이션위젯,
                      SlideTransition(
                        position: Tween(
                          begin: Offset(-1.0, 0.0),
                          end: Offset(0.0, 0.0),
                        ).animate(a1),
                        child: child,
                      )
                  ),
              );
            },),
            // title: Text('MSG App'),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)
                  )
              ),
              // color: Colors.white,
              margin: EdgeInsets.only(left: 55, right: 55, top: 10, bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '기준 장소 - 현위치',
                    // 패딩을 조정하여 아래 선과 아이콘의 위치 일치
                    contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: -1), // 패딩을 조절하여 위치 조절
                    // hintStyle: TextStyle(fontSize: 12),
                    prefixIcon: Icon(Icons.search),
                    // 아래 선을 없애는 부분
                    border: InputBorder.none, // 포커스 되지 않은 상태
                    focusedBorder: InputBorder.none, // 포커스 된 상태
                    enabledBorder: InputBorder.none, // 비활성 상태,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add_box),
                iconSize: 30,
                onPressed: () async {
                  // var picker = ImagePicker();
                  // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                  // if (image != null) {
                  //   setState((){
                  //     userImage = File(image.path);
                  //     print(image.readAsBytes());
                  //     print('선택한 파일의 경로 : ${userImage}');
                  //   });}
                    Navigator.push(context,
                        // MaterialPageRoute(builder: (c) =>Center(child: Upload(userImage: userImage,  userContent: userContent,setUserContent: setUserContent, addMyData: addMyData)))
                        MaterialPageRoute(builder: (c) =>Center(child: UploadSelectPage()))
                    );
                  }

              )
            ],
          ),
        ),
      ),

      body: [
        SampleScreen(), // kakao login page
        kakaoMap(),
        // 코딩 애플 과제
        // HomeWidget(data: data, addData: addData),
        MyImageContainer(),
        MyImageContainer(),
        locationRecommend(),
        // settingPage(),
      ][tab],
      bottomNavigationBar: BottomNavigationBar(
        // 선택된 아이콘을 진하게 만들어준다.
        currentIndex: tab,
        iconSize: 27,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        // 아이콜 아래의 글자 사이즈
        // selectedFontSize: 30,
        // unselectedFontSize: 30,
        onTap: (i){
          setState(() {
            tab = i;
          });
          // 클릭한 탭이 'Favorite' 탭이면 EachPlaceUploadToDaily 페이지로 이동
          if (tab == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EachPlaceUploadToDaily(eachPlace: eachPlace, updateEachPlace: updateEachPlace),
              ),
            );
          }
          // if (tab == 4) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => locationRecommend(),
          //     ),
          //   );
          // }
        },
        items: [
          BottomNavigationBarItem(
            label: '장소 추천',
            icon: Icon(Icons.home),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            label: '공공 장소',
            icon: Icon(Icons.location_on, ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            label: '장소 등록',
            icon: Icon(Icons.add_box_outlined),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            label: '좋아요 누른 장소',
            icon: Icon(Icons.favorite),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            label: '설정',
            icon: Icon(Icons.person),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
