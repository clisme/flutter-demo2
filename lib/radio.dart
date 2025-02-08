import 'package:flutter/material.dart';

void main() {
//  print('Hello, World123!');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('单选组示例'),
        ),
        body: RadioButtonGroup(),
      ),
    );
  }
}

class RadioButtonGroup extends StatefulWidget {
  @override
  _RadioButtonGroupState createState() => _RadioButtonGroupState();
}

class _RadioButtonGroupState extends State<RadioButtonGroup> {
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // 确保列从顶部开始
            crossAxisAlignment: CrossAxisAlignment.start, // 确保列的内容居左对齐
            children: <Widget>[
              Text(
                '怎么这么可爱呀？',
                style: TextStyle(
                  color: Colors.blue, // 设置文本颜色为蓝色
                  fontSize: 20.0, // 设置字体大小
                ),
              ),
            ],
          ),
        ),
        Image.asset(
            // 'https://www.baidu.com/img/flexible/logo/pc/result.png', // 替换为实际的图片URL
            // https://docs.flutter.cn/assets/images/cn/flutter-cn-logo.png
            'assets/images/result.png',
            width: 202, // 可选：设置图片的宽度
            height: 66, // 可选：设置图片的高度
            fit: BoxFit.cover, // 可选：设置图片如何适应给定的宽高
            // loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            //   if (loadingProgress == null) return child;
            //   return Center(
            //     child: CircularProgressIndicator(
            //       value: loadingProgress.expectedTotalBytes != null
            //           ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
            //           : null,
            //     ),
            //   );
            // }, // 可选：自定义加载中的占位符
            // errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            //   return Text('Failed to load image11.'); // 可选：自定义加载失败的占位符
            // },
          ),
        ListTile(
          title: Text('of course'),
          leading: Radio(
            value: 0,
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
              });
              print(_selectedValue);
            },
          ),
        ),
        ListTile(
          title: Text('你说呢123'),
          leading: Radio(
            value: 1,
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
                print(_selectedValue);
              });
            },
          ),
        ),
        ListTile(
          title: Text('🙊'),
          leading: Radio(
            value: 2,
            groupValue: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value!;
                print(_selectedValue);
              });
            },
          ),
        ),
      ],
    );
  }
}


