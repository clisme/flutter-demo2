import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '点餐页面',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FoodOrderPage(),
    );
  }
}

class FoodOrderPage extends StatefulWidget {
  @override
  _FoodOrderPageState createState() => _FoodOrderPageState();
}

class _FoodOrderPageState extends State<FoodOrderPage> {
  // 模拟数据
  final List<Map<String, dynamic>> categories = [
    {'name': '推荐', 'items': [
      {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
          {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
          {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
          {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
          {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
          {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
          {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
          {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
          {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
          {'name': '红烧肉', 'price': 28, 'image': 'https://picsum.photos/200/200?random=1'},
      {'name': '宫保鸡丁', 'price': 22, 'image': 'https://picsum.photos/200/200?random=2'},
    ]},
    {'name': '热销', 'items': [
      {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
          {'name': '麻辣香锅', 'price': 35, 'image': 'https://picsum.photos/200/200?random=3'},
      {'name': '酸菜鱼', 'price': 45, 'image': 'https://picsum.photos/200/200?random=4'},
    ]},
    {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},
      {'name': '套餐', 'items': [
      {'name': '双人套餐', 'price': 68, 'image': 'https://picsum.photos/200/200?random=5'},
      {'name': '家庭套餐', 'price': 98, 'image': 'https://picsum.photos/200/200?random=6'},
    ]},

  ];

  int selectedCategoryIndex = 0; // 当前选中的分类索引
   final ScrollController _scrollController = ScrollController(); // 右侧商品列表的滚动控制器


   @override
  void initState() {
    super.initState();
    // 监听滚动事件
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

    // 滚动监听逻辑
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
      // 滚动到底部，加载下一个分类
      if (selectedCategoryIndex < categories.length - 1) {
        setState(() {
          selectedCategoryIndex++;
          // _scrollController.jumpTo(0); // 重置滚动位置到顶部
        });
      }
    } else if (_scrollController.position.pixels <= _scrollController.position.minScrollExtent + 50) {
      // 滚动到顶部，加载上一个分类
      if (selectedCategoryIndex > 0) {
        setState(() {
          selectedCategoryIndex--;
          // _scrollController.jumpTo(0); // 重置滚动位置到顶部
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('美团外卖'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // 左侧菜单
          Container(
            width: 100, // 左侧菜单宽度
            color: Colors.grey[200],
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                     selectedCategoryIndex = index; // 更新选中的分类
                      // _scrollController.jumpTo(0); // 重置滚动位置到顶部
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    color: selectedCategoryIndex == index ? Colors.white : Colors.grey[200],
                    child: Center(
                      child: Text(
                        categories[index]['name'],
                        style: TextStyle(
                          fontSize: 16,
                          color: selectedCategoryIndex == index ? Colors.orange : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // 右侧商品列表
          Expanded(
            child: ListView.builder(
                 controller: _scrollController, // 绑定滚动控制器
              padding: EdgeInsets.all(8),
              itemCount: categories[selectedCategoryIndex]['items'].length,
              itemBuilder: (context, index) {
                final item = categories[selectedCategoryIndex]['items'][index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      // 商品图片
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      // 商品信息
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '¥${item['price']}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 加购按钮
                      IconButton(
                        icon: Icon(Icons.add_circle, color: Colors.orange),
                        onPressed: () {
                          // 加购逻辑
                          print('加购：${item['name']}');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}