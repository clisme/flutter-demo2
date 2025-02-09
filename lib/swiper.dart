import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PageView Example12'),
        ),
        body: PageViewExample(),
      ),
    );
  }
}

class PageViewExample extends StatefulWidget {
  @override
  _PageViewExampleState createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample> {
  final List<String> imgList = [
    'https://gips0.baidu.com/it/u=838505001,1009740821&fm=3028&app=3028&f=PNG&fmt=auto&q=100&size=f254_80',
    'https://edu-wenku.bdimg.com/v1/pc/aigc/union-index/wk-logo-1729092147280.png'
  ];

  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
    //     if (_currentPage < imgList.length - 1) {
    //       _currentPage++;
    //     } else {
    //       _currentPage = 0;
    //     }

    //     print(111);

    //     if (_pageController.hasClients) {
    //       _pageController.animateToPage(
    //         _currentPage,
    //         duration: Duration(milliseconds: 300),
    //         curve: Curves.easeIn,
    //       );
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _currentPage--;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < imgList.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: (MediaQuery.of(context).size.height / 2) - 50,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
          controller: _pageController,
          itemCount: imgList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10.0),
              // color: Colors.pink,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(imgList[index]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
          },
        ),
      ),
      Positioned(
        left: 10,
        top: MediaQuery.of(context).size.height / 4 - 50,
        child: IconButton(
          icon: Icon(Icons.arrow_back, size: 50, color: Colors.white),
          onPressed: _goToPreviousPage,
        ),
      ),
      Positioned(
        right: 10,
        top: MediaQuery.of(context).size.height / 4 - 50,
        child: IconButton(
          icon: Icon(Icons.arrow_forward, size: 50, color: Colors.white),
          onPressed: _goToNextPage,
        ),
      ),
    ]);
  }
}
