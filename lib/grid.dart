import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '九宫格布局',
      home: Scaffold(
        appBar: AppBar(
          title: Text('九宫格布局示例'),
        ),
        body: GridViewExample(),
      ),
    );
  }
}

class GridViewExample extends StatelessWidget {
  // 模拟数据
  final List<Map<String, String>> items = List.generate(9, (index) {
    return {
      // 'image': 'https://picsum.photos/200/200?random=$index', // 随机图片
      'image':
          'https://edu-wenku.bdimg.com/v1/pc/aigc/union-index/wk-logo-1729092147280.png', // 随机图片
      'text': 'Item ${index + 1}', // 文字内容
    };
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(25), // 内边距
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 每行 3 个格子
        crossAxisSpacing: 10, // 水平间距
        mainAxisSpacing: 10, // 垂直间距
        childAspectRatio: 0.8, // 宽高比
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
            elevation: 5, // 卡片阴影
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // 圆角
            ),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3, // 图片占 3 份
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      child:Container(
                        color:Colors.grey[300], 
                        child: Image.network(
                        items[index]['image']!,
                        fit: BoxFit.fitWidth, // 图片填充
                      ),
                      )
                    ),
                  ),
                  Expanded(
                    flex: 1, // 文字占 1 份
                    child: Center(
                      child: Text(
                        items[index]['text']!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
      },
    );
  }
}
