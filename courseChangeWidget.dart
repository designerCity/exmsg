Widget build(BuildContext context) {
    // inkwell 에 장소들 입력
    Widget subItem(data) {
      return InkWell(
        onTap: () {
          debugPrint('장소 선택');
        },
        // 길게 누르기
        // onLongPress: () {
        //   print('길게 눌러서 순서 바꿀 수 있게끔 만들기');
        // },
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
                        children: <Widget>[
                          // a= const TextStyle(fontWeight: FontWeight.bold);
                          Text('장소 ${data.toString()}'),
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
              ), // 오른쪽의 요금
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('길게 눌러서 코스 순서를 변경해보세요'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sort_by_alpha),
        onPressed: () {
          setState(() {
            isSort = !isSort;
            _items.sort((a, b) => isSort ? a.compareTo(b) : b.compareTo(a));
          });
        },
      ),
      body: ReorderableListView(
        // 순서 정렬
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            final moveItem = _items.removeAt(oldIndex);
            _items.insert(newIndex, moveItem);
          });
        },
        // 아이템 배치
        children: _items
            .map((item) => ListTile(
          key: Key(item),
          // 위젯 배치
          title: subItem(_items),
          subtitle: Text('Item : $item'),
          // leading: Icon(Icons.drag_handle),
        ))
            .toList(),
      ),
    );
  }
