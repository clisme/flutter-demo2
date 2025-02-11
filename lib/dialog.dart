import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 去掉 debug 显示
      theme: ThemeData(
        primaryColor: Colors.blue, // 设置主色调
        primarySwatch: Colors.blue, // 设置主色调
        hintColor: Colors.orange, // 设置强调色
        scaffoldBackgroundColor: Colors.grey[200], // 设置背景色为淡灰色
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue, // 设置按钮背景色
          textTheme: ButtonTextTheme.primary, // 设置按钮文本颜色
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // 设置ElevatedButton背景色
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white, // 设置弹窗背景色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form Example1'),
          backgroundColor: Colors.deepOrange,
        ),
        body: FormExample(),
        // backgroundColor: Colors.grey[200], // 设置背景色为淡灰色
      ),
    );
  }
}

class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('自定义弹窗'),
          content: Text('这是一个自定义的弹窗内容。'),
          actions: <Widget>[
            TextButton(
              child: Text('关闭'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('确认'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 360,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '底部弹窗',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text('这是一个从底部弹出的圆角弹窗。'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('关闭'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            onPressed: () => _showCustomDialog(context),
            child: Text('显示弹窗'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => _showBottomSheet(context),
            child: Text('显示底部弹窗'),
          ),
        ],
      ),
    );
  }
}
