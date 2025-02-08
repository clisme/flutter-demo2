import 'package:flutter/material.dart';
import 'package:flutter_application_2/third_page.dart';
import 'second_page.dart'; // 导入 second_page.dart 文件



class FirstPage extends StatelessWidget {

   final String info;

  // 构造函数接收参数
  // FirstPage({ this.info='123'});
  FirstPage({ required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page111'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Received message:'),
            Text(
              info,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/second');

                // 通过构造函数传递参数
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SecondPage(message: 'Hello from First Page!'),
                  ),
                );
              },
              child: Text('Go to Second Page'),
            ),
               ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/second');

                // 通过构造函数传递参数
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                       ThirdPage(message: 'Hello from First Page!'),
                  ),
                );
              },
              child: Text('Go to 3 Page'),
            ),
          ],
        ),
      ),
    );
  }
}
