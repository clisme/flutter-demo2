// import 'package:flutter/material.dart';
// // import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'; // 导入基础库
// import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('百度地图示例'),
//         ),
//         body: BaiduMapExample(),
//       ),
//     );
//   }
// }

// class BaiduMapExample extends StatefulWidget {
//   @override
//   _BaiduMapExampleState createState() => _BaiduMapExampleState();
// }

// class _BaiduMapExampleState extends State<BaiduMapExample> {
//   late BMFMapController _controller;
//   BMFMapOptions mapOptions = BMFMapOptions(
//         center: BMFCoordinate(39.917215, 116.380341),
//         zoomLevel: 12,
//         mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('百度地图示例'),
//       ),
//       body:SizedBox(
//       height: 100,
//       width: 100,
//       child: BMFMapWidget(
//         onBMFMapCreated: (controller) {
//           _onMapCreated(controller);
//         },
//         mapOptions: mapOptions,
//       ),
//     );
//     );
//   }

//   void _onMapCreated(BMFMapController controller) {
//     _controller = controller;
//     _setMapCenter();
//     // _addMarker();
//   }

//   void _setMapCenter() {
//     _controller.setCenterCoordinate(
//       BMFCoordinate( 39.908722,  116.397478)); // 移除分号

//   }

//   // void _addMarker() {
//   //   BMFMarker marker = BMFMarker(
//   //     position: BMFCoordinate(latitude: 39.908722, longitude: 116.397478),
//   //     title: '标记',
//   //   );
//   //   _controller.addMarker(marker);
//   // }
// }