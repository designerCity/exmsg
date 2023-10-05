import 'package:flutter/material.dart';

class loactionRecommend extends StatefulWidget {
  const loactionRecommend({super.key});

  @override
  State<loactionRecommend> createState() => _loactionRecommendState();
}

class _loactionRecommendState extends State<loactionRecommend> {
  // scroll 을 하기 위한
  var scroll = ScrollController();
  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if ((scroll.position.pixels == scroll.position.maxScrollExtent)) {
        print('다 내려감');
      } else if ((scroll.position.pixels == scroll.position.maxScrollExtent)) {
        print('2 번째로 내려감.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: subItem(Icons.person_pin_circle_rounded, '추천순', '당신의 취향에 맞춘 서비스')),
              Container(
                width: 1,
                height: 24,
                color: Colors.grey.withOpacity(0.2),
              ),
              Expanded(child: subItem(Icons.my_location_outlined, '거리순', '당신과 가까운 장소 추천')),
            ],
          ), // 추천순 / 거리순 버튼

          InkWell(
            onTap: () {
            debugPrint('장소 선택');
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
          ), // 추천하는 장소
          Container(
            height: 200,
            child: Expanded(
                child: Container(
                  color: Colors.red,
                )
            ),
          ), // 추천하는 장소
        ],
      );
  }




  Widget subItem(IconData icon, String title, String content) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 20),
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

