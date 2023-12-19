import 'package:flutter/material.dart';




class iconTagSelect extends StatefulWidget {

  final addIconTextReal;
  iconTagSelect({required this.addIconTextReal});
  @override
  State<iconTagSelect> createState() => _iconTagSelectState();
}

class _iconTagSelectState extends State<iconTagSelect> {

  final PageController _controller = PageController();

  List<IconTextPairs> iconTextListSub = [];
  void addIconText(icon, text) {
    iconTextListSub.add(IconTextPairs(icon: icon, text: text));
  }
  @override
  void initState() {
    super.initState();
    /// 불러오는 method
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인 페이지'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff71be90), // 시작 색상
                Color(0xff8bd8a3), // 시작 색상
                Color(0xff71be90), // 시작 색상
                Color(0xff8bd8a3), // 시작 색상
                Colors.green, // 끝 색상
              ],
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('활동', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    // 드래그 거리에 따라 페이지 컨트롤러의 위치를 업데이트합니다.
                    _controller.position.moveTo(_controller.position.pixels - details.delta.dx);
                  },
                  onHorizontalDragEnd: (details) {
                    // 드래그가 끝나면 플링 효과를 내기 위해 페이지 컨트롤러에 애니메이션을 적용합니다.
                    if (details.velocity.pixelsPerSecond.dx.abs() > 100) {
                      double offset = _controller.offset + (details.velocity.pixelsPerSecond.dx > 0 ? -300 : 300);
                      _controller.animateTo(
                        offset,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.restaurant_menu, text: '식사', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.chat, text: '대화', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.forest, text: '휴식',addIconText: addIconText ),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.bed, text: '숙박',addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.coffee, text: '음료',addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.local_bar, text: '술',addIconText: addIconText),
                        SizedBox(width: 20,),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('감정', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    // 드래그 거리에 따라 페이지 컨트롤러의 위치를 업데이트합니다.
                    _controller.position.moveTo(_controller.position.pixels - details.delta.dx);
                  },
                  onHorizontalDragEnd: (details) {
                    // 드래그가 끝나면 플링 효과를 내기 위해 페이지 컨트롤러에 애니메이션을 적용합니다.
                    if (details.velocity.pixelsPerSecond.dx.abs() > 100) {
                      double offset = _controller.offset + (details.velocity.pixelsPerSecond.dx > 0 ? -300 : 300);
                      _controller.animateTo(
                        offset,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.sentiment_very_satisfied, text: '매우 만족', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.sentiment_satisfied, text: '만족',addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.sentiment_neutral, text: '평범', addIconText: addIconText),
                        SizedBox(width: 20,),

                        CustomContainerWidget(icon: Icons.sentiment_dissatisfied, text: '불만', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.sentiment_very_dissatisfied, text: '매우 불만', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.mood, text: '좋은 기분', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.mood_bad, text: '나쁜 기분', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.tag_faces, text: '웃는 표정', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.sentiment_satisfied_alt, text: '만족', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.sentiment_very_dissatisfied, text: '매우 불만', addIconText: addIconText),
                        SizedBox(width: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('밀도', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    // 드래그 거리에 따라 페이지 컨트롤러의 위치를 업데이트합니다.
                    _controller.position.moveTo(_controller.position.pixels - details.delta.dx);
                  },
                  onHorizontalDragEnd: (details) {
                    // 드래그가 끝나면 플링 효과를 내기 위해 페이지 컨트롤러에 애니메이션을 적용합니다.
                    if (details.velocity.pixelsPerSecond.dx.abs() > 100) {
                      double offset = _controller.offset + (details.velocity.pixelsPerSecond.dx > 0 ? -300 : 300);
                      _controller.animateTo(
                        offset,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.restaurant_menu, text: '식사',addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.chat, text: '대화',addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.bed, text: '숙박', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.do_not_disturb_alt, text: '조용함', addIconText: addIconText),
                        SizedBox(width: 20,),
                        CustomContainerWidget(icon: Icons.coffee, text: '카페', addIconText: addIconText),
                        SizedBox(width: 20,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.addIconTextReal(iconTextListSub);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyIconPage()),
                        );
                        /// 완료 버튼 이후에 임시 저장
                        // Navigator.pop(context); // 선택된 태그들을 반환하며 이전 페이지로 이동
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // 배경 색상
                        onPrimary: Colors.black, // 텍스트 색상
                        // 추가적인 스타일링: 패딩, 라운드 모서리 등
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text('완료'),
                    ),
                    SizedBox(width: 30,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // 선택된 태그들을 반환하며 이전 페이지로 이동
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // 배경 색상
                        onPrimary: Colors.white, // 텍스트 색상
                        // 추가적인 스타일링: 패딩, 라운드 모서리 등
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text('취소'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class IconTextPairs {
  IconData icon;
  String text;

  IconTextPairs({required this.icon, required this.text});
}
class CustomContainerWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final addIconText;
  CustomContainerWidget({required this.icon, required this.text, required this.addIconText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // iconTextList.add(IconTextPair(icon: icon, text: text));
        addIconText(icon, text);
        // print('${iconTextList[iconTextList.length - 1].text}');
      },
      child: Container(
        width: 70,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff455438),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffebebed),
              ),
              width: 60,
              height: 55,
              child: Center(
                child: Icon(icon, size: 50),
              ),
            ),
            SizedBox(height: 1,),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MyIconPage extends StatefulWidget {
  @override
  _MyIconPageState createState() => _MyIconPageState();
}

class _MyIconPageState extends State<MyIconPage> {
  bool isExpanded = false;

  void toggleIcon() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              onTap: toggleIcon,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                alignment: isExpanded ? Alignment.center : Alignment.topLeft,
                child: Icon(
                  Icons.favorite,
                  size: isExpanded ? 200 : 100,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          if (isExpanded)
            Positioned.fill(
              child: Center(
                child: Text('새로운 레이아웃이 여기에 표시됩니다.'),
              ),
            ),
        ],
      ),
    );
  }
}
