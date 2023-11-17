import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';


class MyChartPage extends StatefulWidget {
  @override
  State<MyChartPage> createState() => _MyChartPageState();
}
/// bar 를 직접 만들자
class _MyChartPageState extends State<MyChartPage> {
  /// place list
  var placeList = [];
  var placeLongList = [];

  /// 각 장소
  var listStart = [];
  var rowLong = [];
  var firstRowLength;
  var colorList = [];
  void _calculateRows(start, endTime, beforeHour) {
    var endHour = endTime[0];
    var endMin = endTime[1];
    var startHour = start[0];
    var startMin = start[1];
    var listStart = <double>[]; // Create a new list for each call
    var rowLong = <double>[]; // Create a new list for each call

    Color generateRandomColor() {
      Random random = Random();
      return Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0,
      );
    }
    listStart.clear();
    rowLong.clear();

    while (!(endHour == startHour && endMin == startMin)) {
      listStart.add(startMin / 10);
      if (endHour == startHour) {
        firstRowLength = endMin - startMin;
      } else {
        firstRowLength = 60 - startMin; // 기간
      }
      startMin = firstRowLength + startMin;
      if (startMin == 60) {
        startMin = 0;
        startHour += 1;
      }
      rowLong.add(firstRowLength / 10);
    }
    // print(rowLong);
    // print(listStart);
    colorList.add(generateRandomColor());
    placeLongList.add(rowLong);
    placeList.add(listStart);
    print(placeLongList);
    print(placeList);
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _calculateRows(
        [1, 10], // 각 장소에 해당하는 시작 시간
        [3, 10], // 각 장소에 해당하는 종료 시간
        0
      );
      _calculateRows(
        [3, 20], // 각 장소에 해당하는 시작 시간
        [4, 50], // 각 장소에 해당하는 종료 시간
        3,
      );
    });
  }
  Color myColor = Colors.blue; // 이 부분에서 색상을 변경할 수 있습니다.

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [Column(
        children: List.generate(2, (placeIndex) {
          print('placeIndex: ${placeIndex}');
          print('${
            // placeList[placeIndex].length
              placeLongList[placeIndex]
          }');

          // return Container();
          return
            Column(
              children:
                List.generate(placeLongList[placeIndex].length, (index) {
                  // int currentPlaceIndex = placeLongList[placeIndex][index];
                  var currentPlaceIndex = placeLongList[placeIndex][index];
                  myColor = colorList[placeIndex];
                  print('${
                  // placeList[placeIndex].length
                      placeLongList[placeIndex][index]
                  }');
                  // return Container();
                  return Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.14 * placeList[placeIndex][index],
                        height: MediaQuery.of(context).size.height * 0.1,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: myColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(40), // 여기서 모서리의 반경을 조절합니다.
                        ),
                        width: MediaQuery.of(context).size.width * 0.14 * placeLongList[placeIndex][index],
                        height: MediaQuery.of(context).size.height * 0.1,

                      ),
                  ],
                );
              }),

              // [Container(
              //   height: 300,
              //   child: HourWidget(
              //     start: [1, 10], // 각 장소에 해당하는 시작 시간
              //     endTime: [3, 10], // 각 장소에 해당하는 종료 시간
              //     placeAdd : placeAdd
              //   ),
              // ),
              // Container(
              //   height: 500,
              //   child: HourWidget(
              //     start: [3, 20], // 각 장소에 해당하는 시작 시간
              //     endTime: [4, 50], // 각 장소에 해당하는 종료 시간
              //     placeAdd : placeAdd
              //   ),
              // ),]

            );
        }
      )
    ),]
    );
  }
  @override
  void dispose() {
    // 정리 코드 추가
    super.dispose();
  }
}

class HourWidget extends StatefulWidget {
  const HourWidget({super.key,
    required this.start, required this.endTime, required this.placeAdd
  });
  final start;
  final endTime;
  final placeAdd;

  @override
  State<HourWidget> createState() => _HourWidgetState();
}

class _HourWidgetState extends State<HourWidget> {
  var endHour;
  var endMin;
  var startHour;
  var startMin;
  var listStart = [];
  var rowLong = [];
  var firstRowLength;

  @override
  void initState() {
    super.initState();
    _calculateRows();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rowLong.length, (index) {
        return Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.14 * listStart[index],
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.white.withOpacity(0.1),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.14 * rowLong[index],
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.blueAccent.withOpacity(0.1),
            ),
          ],
        );
      }),
    );
  }

  void _calculateRows() {
    endHour = widget.endTime[0];
    endMin = widget.endTime[1];
    startHour = widget.start[0];
    startMin = widget.start[1];

    listStart.clear();
    rowLong.clear();

    while (!(endHour == startHour && endMin == startMin)) {
      listStart.add(startMin / 10);
      if (endHour == startHour) {
        firstRowLength = endMin - startMin;
      } else {
        firstRowLength = 60 - startMin; // 기간
      }
      startMin = firstRowLength + startMin;
      if (startMin == 60) {
        startMin = 0;
        startHour += 1;
      }
      rowLong.add(firstRowLength / 10);
    }

    print(rowLong);
  }

  @override
  void dispose() {
    // 정리 코드 추가
    super.dispose();
  }
}



