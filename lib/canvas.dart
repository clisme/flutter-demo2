// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '柱状图示例',
//       home: Scaffold(
//         appBar: AppBar(title: Text('柱状图示例')),
//         body: Padding(
//           padding: EdgeInsets.all(20),
//           child: BarChart(
//             data: [
//               BarData(value: 35, label: '一月', color: Colors.blue),
//               BarData(value: 60, label: '二月', color: Colors.green),
//               BarData(value: 85, label: '三月', color: Colors.orange),
//               BarData(value: 45, label: '四月', color: Colors.red),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BarData {
//   final double value;
//   final String label;
//   final Color color;

//   BarData({required this.value, required this.label, required this.color});
// }

// class BarChart extends StatefulWidget {
//   final List<BarData> data;
  
//   const BarChart({super.key, required this.data});

//   @override
//   _BarChartState createState() => _BarChartState();
// }

// class _BarChartState extends State<BarChart> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   int? _selectedBarIndex;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onBarTapped(int index) {
//     setState(() {
//       _selectedBarIndex = _selectedBarIndex == index ? null : index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return GestureDetector(
//           onTapDown: (details) {
//             final RenderBox renderBox = context.findRenderObject() as RenderBox;
//             final localPosition = renderBox.globalToLocal(details.globalPosition);
//             final chartPadding = 40.0;
//             final availableWidth = constraints.maxWidth - chartPadding * 2;
//             final barWidth = (availableWidth - (widget.data.length - 1) * _BarChartPainter.barSpacing) / widget.data.length;

//             for (int i = 0; i < widget.data.length; i++) {
//               final xPos = chartPadding + i * (barWidth + _BarChartPainter.barSpacing);
//               if (localPosition.dx >= xPos && localPosition.dx <= xPos + barWidth) {
//                 _onBarTapped(i);
//                 _showBarDetails(widget.data[i]);
//                 break;
//               }
//             }
//           },
//           child: CustomPaint(
//             size: Size(constraints.maxWidth, constraints.maxHeight),
//             painter: _BarChartPainter(data: widget.data, animation: _animation, selectedBarIndex: _selectedBarIndex),
//           ),
//         );
//       },
//     );
//   }

//   void _showBarDetails(BarData barData) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(barData.label),
//           content: Text('Value: ${barData.value.toInt()}'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class _BarChartPainter extends CustomPainter {
//   final List<BarData> data;
//   final Animation<double> animation;
//   final int? selectedBarIndex;
//   static const double barSpacing = 20;
//   static const double axisWidth = 2;
//   static const double labelFontSize = 12;
//   static const int yAxisSteps = 5;

//   _BarChartPainter({required this.data, required this.animation, required this.selectedBarIndex}) : super(repaint: animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
//     final chartPadding = 40.0;
//     final availableHeight = size.height - chartPadding * 2;
//     final availableWidth = size.width - chartPadding * 2;

//     // 绘制背景
//     final bgPaint = Paint()..color = Colors.grey[200]!;
//     canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

//     // 绘制Y轴
//     final axisPaint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = axisWidth;

//     // Y轴刻度
//     final textStyle = TextStyle(
//       color: Colors.black,
//       fontSize: labelFontSize,
//     );
//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//       textAlign: TextAlign.right,
//     );

//     for (int i = 0; i <= yAxisSteps; i++) {
//       final value = maxValue * i / yAxisSteps;
//       final yPos = size.height - chartPadding - (availableHeight * i / yAxisSteps);
      
//       // 绘制刻度线
//       canvas.drawLine(
//         Offset(chartPadding - 5, yPos),
//         Offset(chartPadding, yPos),
//         axisPaint,
//       );

//       // 绘制刻度值
//       textPainter.text = TextSpan(
//         text: '${value.toInt()}',
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(chartPadding - 10 - textPainter.width, yPos - 6),
//       );
//     }

//     // 绘制柱子
//     final barWidth = (availableWidth - (data.length - 1) * barSpacing) / data.length;
//     for (int i = 0; i < data.length; i++) {
//       final barData = data[i];
//       final barHeight = availableHeight * (barData.value / maxValue) * animation.value;
//       final xPos = chartPadding + i * (barWidth + barSpacing);
//       final yPos = size.height - chartPadding - barHeight;

//       // 绘制柱子
//       final barPaint = Paint()
//         ..color = (selectedBarIndex == i) ? Colors.yellow : barData.color
//         ..style = PaintingStyle.fill;
//       canvas.drawRect(
//         Rect.fromLTWH(xPos, yPos, barWidth, barHeight),
//         barPaint,
//       );

//       // 绘制数值标签
//       textPainter.text = TextSpan(
//         text: '${(barData.value * animation.value).toInt()}',
//         style: textStyle.copyWith(color: Colors.white),
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(
//           xPos + barWidth/2 - textPainter.width/2,
//           yPos - 20,
//         ),
//       );

//       // 绘制X轴标签
//       textPainter.text = TextSpan(
//         text: barData.label,
//         style: textStyle,
//       );
//       textPainter.layout();
//       textPainter.paint(
//         canvas,
//         Offset(
//           xPos + barWidth/2 - textPainter.width/2,
//           size.height - chartPadding + 10,
//         ),
//       );
//     }

//     // 绘制坐标轴
//     canvas.drawLine(
//       Offset(chartPadding, chartPadding),
//       Offset(chartPadding, size.height - chartPadding),
//       axisPaint,
//     );
//     canvas.drawLine(
//       Offset(chartPadding, size.height - chartPadding),
//       Offset(size.width - chartPadding, size.height - chartPadding),
//       axisPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }





// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '球形流体图示例',
//       home: Scaffold(
//         appBar: AppBar(title: Text('球形流体图示例')),
//         body: Center(
//           child: FluidSphereChart(),
//         ),
//       ),
//     );
//   }
// }

// class FluidSphereChart extends StatefulWidget {
//   @override
//   _FluidSphereChartState createState() => _FluidSphereChartState();
// }

// class _FluidSphereChartState extends State<FluidSphereChart> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     )..repeat();
//     _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return CustomPaint(
//           size: Size(300, 300),
//           painter: FluidSpherePainter(angle: _animation.value),
//         );
//       },
//     );
//   }
// }

// class FluidSpherePainter extends CustomPainter {
//   final double angle;

//   FluidSpherePainter({required this.angle});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2 - 20;

//     // 绘制背景
//     final bgPaint = Paint()..color = Colors.grey[200]!;
//     canvas.drawCircle(center, radius, bgPaint);

//     // 绘制球体
//     final spherePaint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill;
//     canvas.drawCircle(center, radius, spherePaint);

//     // 绘制流体效果
//     final fluidPaint = Paint()
//       ..color = Colors.blue.withOpacity(0.5)
//       ..style = PaintingStyle.fill;

//     final path = Path();
//     path.moveTo(center.dx + radius * math.cos(angle), center.dy + radius * math.sin(angle));

//     for (double i = 0; i <= 2 * math.pi; i += 0.1) {
//       final x = center.dx + radius * math.cos(i + angle);
//       final y = center.dy + radius * math.sin(i + angle);
//       path.lineTo(x, y);
//     }

//     path.close();
//     canvas.drawPath(path, fluidPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }





// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '签名板示例',
//       home: Scaffold(
//         appBar: AppBar(title: Text('签名板示例')),
//         body: Center(
//           child: SignaturePad(),
//         ),
//       ),
//     );
//   }
// }

// class SignaturePad extends StatefulWidget {
//   @override
//   _SignaturePadState createState() => _SignaturePadState();
// }

// class _SignaturePadState extends State<SignaturePad> {
//   List<Offset?> _points = <Offset?>[];

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: (DragUpdateDetails details) {
//         setState(() {
//           RenderBox renderBox = context.findRenderObject() as RenderBox;
//           Offset localPosition = renderBox.globalToLocal(details.globalPosition);
//           _points = List.from(_points)..add(localPosition);
//         });
//       },
//       onPanEnd: (DragEndDetails details) => _points.add(null),
//       child: CustomPaint(
//         painter: SignaturePainter(points: _points),
//         size: Size.infinite,
//       ),
//     );
//   }
// }

// class SignaturePainter extends CustomPainter {
//   final List<Offset?> points;

//   SignaturePainter({required this.points});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.black
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 5.0;

//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i]!, points[i + 1]!, paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(SignaturePainter oldDelegate) => oldDelegate.points != points;
// }



// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'dart:ui' as ui;
// import 'dart:typed_data';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '签名板示例',
//       home: Scaffold(
//         appBar: AppBar(title: Text('签名板示例')),
//         body: Center(
//           child: SignaturePad(),
//         ),
//       ),
//     );
//   }
// }

// class SignaturePad extends StatefulWidget {
//   @override
//   _SignaturePadState createState() => _SignaturePadState();
// }

// class _SignaturePadState extends State<SignaturePad> {
//   List<Offset?> _points = <Offset?>[];
//   GlobalKey _globalKey = GlobalKey();
//   bool _isErasing = false;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _points.clear();
//                 });
//               },
//               child: Text('清除'),
//             ),
//             SizedBox(width: 10),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   if (_points.isNotEmpty) {
//                     _points.removeLast();
//                   }
//                 });
//               },
//               child: Text('回退'),
//             ),
//             SizedBox(width: 10),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _isErasing = !_isErasing;
//                 });
//               },
//               child: Text(_isErasing ? '画笔' : '橡皮擦'),
//             ),
//             SizedBox(width: 10),
//             ElevatedButton(
//               onPressed: _saveSignature,
//               child: Text('保存'),
//             ),
//           ],
//         ),
//         Expanded(
//           child: RepaintBoundary(
//             key: _globalKey,
//             child: GestureDetector(
//               onPanUpdate: (details) {
//                 setState(() {
//                   RenderBox renderBox = context.findRenderObject() as RenderBox;
//                   _points.add(renderBox.globalToLocal(details.globalPosition));
//                 });
//               },
//               onPanEnd: (details) {
//                 _points.add(null);
//               },
//               child: CustomPaint(
//                 painter: SignaturePainter(_points, _isErasing),
//                 size: Size.infinite,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _saveSignature() async {
//     try {
//       RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage();
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       Uint8List pngBytes = byteData!.buffer.asUint8List();

//       final directory = (await getApplicationDocumentsDirectory()).path;
//       final imgFile = File('$directory/signature.png');
//       await imgFile.writeAsBytes(pngBytes);

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('签名已保存')));
//     } catch (e) {
//       print(e);
//     }
//   }
// }

// class SignaturePainter extends CustomPainter {
//   final List<Offset?> points;
//   final bool isErasing;

//   SignaturePainter(this.points, this.isErasing);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = isErasing ? Colors.white : Colors.black
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = 5.0;

//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i]!, points[i + 1]!, paint);
//       } else if (points[i] != null && points[i + 1] == null) {
//         canvas.drawPoints(ui.PointMode.points, [points[i]!], paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(SignaturePainter oldDelegate) => oldDelegate.points != points || oldDelegate.isErasing != isErasing;
// }







import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '签名板示例',
      home: Scaffold(
        appBar: AppBar(title: Text('签名板示例')),
        body: Center(
          child: SignaturePad(),
        ),
      ),
    );
  }
}

class SignaturePad extends StatefulWidget {
  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  List<Offset?> _points = <Offset?>[];
  GlobalKey _globalKey = GlobalKey();
  bool _isErasing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _points.clear();
                });
              },
              child: Text('清除'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_points.isNotEmpty) {
                    _points.removeLast();
                  }
                });
              },
              child: Text('回退'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isErasing = !_isErasing;
                });
              },
              child: Text(_isErasing ? '画笔' : '橡皮擦'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: _saveSignature,
              child: Text('保存'),
            ),
          ],
        ),
        Expanded(
          child: RepaintBoundary(
            key: _globalKey,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  _points.add(renderBox.globalToLocal(details.globalPosition));
                });
              },
              onPanEnd: (details) {
                _points.add(null);
              },
              child: CustomPaint(
                painter: SignaturePainter(_points, _isErasing),
                size: Size.infinite,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _saveSignature() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = (await getApplicationDocumentsDirectory()).path;
      final imgFile = File('$directory/signature.png');
      await imgFile.writeAsBytes(pngBytes);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('签名已保存')));
    } catch (e) {
      print(e);
    }
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  final bool isErasing;

  SignaturePainter(this.points, this.isErasing);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isErasing ? Colors.white : Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        // 绘制连续线条
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        // 绘制单个点（用于处理抬起手时的断点）
        canvas.drawPoints(ui.PointMode.points, [points[i]!], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points || oldDelegate.isErasing != isErasing;
}