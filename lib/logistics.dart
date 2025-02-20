// import 'package:flutter/material.dart';

// class LogisticsDetailPage extends StatefulWidget {
//   @override
//   _LogisticsDetailPageState createState() => _LogisticsDetailPageState();
// }

// class _LogisticsDetailPageState extends State<LogisticsDetailPage> {
//   List<String> logisticsData = [
//     "北京分拣中心 - 2023-10-01 10:00",
//     "上海分拣中心 - 2023-10-02 14:00",
//     "广州分拣中心 - 2023-10-03 09:00",
//     "深圳分拣中心 - 2023-10-04 16:00",
//   ];

//   void _showLogisticsPanel() {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 '最新送达地点',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: logisticsData.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(logisticsData[index]),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('物流详情'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _showLogisticsPanel,
//           child: Text('查看物流详情'),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: LogisticsDetailPage(),
//   ));
// }




// import 'package:flutter/material.dart';

// class LogisticsDetailPage extends StatefulWidget {
//   @override
//   _LogisticsDetailPageState createState() => _LogisticsDetailPageState();
// }

// class _LogisticsDetailPageState extends State<LogisticsDetailPage> {
//   List<String> logisticsData = [
//     "北京分拣中心 - 2023-10-01 10:00",
//     "上海分拣中心 - 2023-10-02 14:00",
//     "广州分拣中心 - 2023-10-03 09:00",
//     "深圳分拣中心 - 2023-10-04 16:00",
//   ];

//   void _showLogisticsPanel() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         double screenHeight = MediaQuery.of(context).size.height;
//         double minHeight = 100; // 100px
//         double midHeight = screenHeight * 0.4; // 40% 屏幕高度
//         double maxHeight = screenHeight * 0.7; // 70% 屏幕高度

//         return DraggableScrollableSheet(
//           initialChildSize: 0.4, // 初始高度为屏幕的40%
//           minChildSize: 0.1, // 最小高度为屏幕的10%（约100px）
//           maxChildSize: 0.7, // 最大高度为屏幕的70%
//           snap: true, // 启用停靠点
//           snapSizes: [0.1, 0.4, 0.7], // 设置停靠点
//           builder: (BuildContext context, ScrollController scrollController) {
//             return NotificationListener<DraggableScrollableNotification>(
//               onNotification: (notification) {
//                 double currentHeight = notification.extent;

//                 if (currentHeight <= minHeight / screenHeight) {
//                   print("面板高度为 100px");
//                 } else if (currentHeight >= midHeight / screenHeight && currentHeight < maxHeight / screenHeight) {
//                   print("面板高度为 40% 屏幕高度");
//                 } else if (currentHeight >= maxHeight / screenHeight) {
//                   print("面板高度为 70% 屏幕高度");
//                 }
//                 return true;
//               },
//               child: Container(
//                 padding: EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Text(
//                       '最新送达地点',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10),
//                     Expanded(
//                       child: ListView.builder(
//                         controller: scrollController,
//                         itemCount: logisticsData.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text(logisticsData[index]),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('物流详情'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _showLogisticsPanel,
//           child: Text('查看物流详情'),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: LogisticsDetailPage(),
//   ));
// }







//  step

// import 'package:flutter/material.dart';

// class LogisticsDetailPage extends StatefulWidget {
//   @override
//   _LogisticsDetailPageState createState() => _LogisticsDetailPageState();
// }

// class _LogisticsDetailPageState extends State<LogisticsDetailPage> {
//   int _currentStep = 0; // 当前步骤
//   List<Map<String, String>> logisticsData = [
//     {"location": "北京分拣中心", "time": "2023-10-01 10:00"},
//     {"location": "上海分拣中心", "time": "2023-10-02 14:00"},
//     {"location": "广州分拣中心", "time": "2023-10-03 09:00"},
//     {"location": "深圳分拣中心", "time": "2023-10-04 16:00"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('物流详情'),
//       ),
//       body: Stepper(
//         currentStep: _currentStep,
//         onStepTapped: (int step) {
//           setState(() {
//             _currentStep = step;
//           });
//         },
//         steps: logisticsData.map((data) {
//           return Step(
//             title: Text(data["location"]!),
//             subtitle: Text(data["time"]!),
//             content: Container(), // 内容可以为空
//             isActive: _currentStep >= logisticsData.indexOf(data),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: LogisticsDetailPage(),
//   ));
// }



//  自定义、
import 'package:flutter/material.dart';

class LogisticsDetailPage extends StatefulWidget {
  @override
  _LogisticsDetailPageState createState() => _LogisticsDetailPageState();
}

class _LogisticsDetailPageState extends State<LogisticsDetailPage> {
  List<Map<String, String>> logisticsData = [
    {"location": "北京分拣中心", "time": "2023-10-01 10:00"},
    {"location": "上海分拣中心", "time": "2023-10-02 14:00"},
    {"location": "广州分拣中心", "time": "2023-10-03 09:00"},
    {"location": "深圳分拣中心", "time": "2023-10-04 16:00"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('物流详情'),
      ),
      body: ListView.builder(
        itemCount: logisticsData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: index == 0 ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      if (index != logisticsData.length - 1)
                        Container(
                          width: 2,
                          height: 50,
                          color: Colors.grey,
                        ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          logisticsData[index]["location"]!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          logisticsData[index]["time"]!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (index != logisticsData.length - 1) SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LogisticsDetailPage(),
  ));
}