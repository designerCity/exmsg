class CustomContainerWidget extends StatefulWidget {
  final IconData icon;
  final String text;

  CustomContainerWidget({required this.icon, required this.text});

  @override
  _CustomContainerWidgetState createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  bool isSelected = false; // 위젯의 선택 상태

  List<IconData> selectedIcons = []; // 선택된 아이콘들을 저장할 리스트

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => iconTagSelect()),
    );

    // 태그 선택 페이지로부터 결과를 받으면
    if (result != null) {
      setState(() {
        selectedIcons = result;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected; // 상태 토글
          print('${widget.text}');
        });

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => iconTagSelect()),
        );
        print('asd');
      },
      child: Container(
        width: 70,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Color(0xff455438) : Colors.grey, // 상태에 따른 색상 변경
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isSelected ? Color(0xffebebed) : Colors.transparent, // 상태에 따른 색상 변경
              ),
              width: 60,
              height: 55,
              child: Center(
                child: Icon(isSelected ? widget.icon : Icons.add_box, size: 50), // 상태에 따른 아이콘 변경
              ),
            ),
            SizedBox(height: 1,),
            if (isSelected) // 텍스트는 선택됐을 때만 표시
              Center(
                child: Text(
                  widget.text,
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

GestureDetector(
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
                      CustomContainerWidget(
                        icon: Icons.restaurant_menu, text: '식사',),
                      for (var icon in selectedIcons)
                        Icon(icon, size: 50),
                      SizedBox(width: 20,),
                      CustomContainerWidget(icon: Icons.chat, text: '대화',),
                      SizedBox(width: 20,),
                      CustomContainerWidget(icon: Icons.bed, text: '숙박'),
                      SizedBox(width: 20,),
                      CustomContainerWidget(icon: Icons.do_not_disturb_alt, text: '조용함'),
                      SizedBox(width: 20,),
                      CustomContainerWidget(icon: Icons.coffee, text: '카페'),
                      SizedBox(width: 20,),
                    ],
                  ),
                ),
              ),
