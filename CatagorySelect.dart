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
Container(
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3), // shadow offset
                            ),
                          ],
                        ),
                        child: DropdownButton<String>(
                          value: selectedDropdown,
                          elevation : 2, // dropdown menu elevation
                          iconSize : 24, // dropdown arrow icon size
                          style : TextStyle(color : Colors.black, fontSize : 16), // dropdown text style
                          underline : Container(), // remove default underline

                          items: dropdownList.map((String item) {
                            return DropdownMenuItem<String>(
                              value:item,
                              child : Padding(
                                padding : EdgeInsets.symmetric(vertical :10, horizontal :16), // item padding
                                child :
                                Text(
                                  '$item',
                                  style :
                                  TextStyle(fontSize :15, fontWeight : FontWeight.bold),
                                ),
                              ),
                            );
                          }).toList(),

                          onChanged:(dynamic value) {
                            setState(() {
                              selectedDropdown = value;
                            });
                          },
                        ),
                      ), // 장소 카테고리 선택 버튼
