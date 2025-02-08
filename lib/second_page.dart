import 'package:flutter/material.dart';
import 'first_page.dart';

class SecondPage extends StatelessWidget {
  final String message;

  // 构造函数接收参数
  SecondPage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Received message:'),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pop(context,'Hello from 2 Page!');
                 Navigator.pushReplacement(
                 context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FirstPage(info: ' from 2 Page!'),
                  ),
                );
              },
              child: Text('Go back to First Page'),
            ),
          ],
        ),
      ),
    );
  }
}
