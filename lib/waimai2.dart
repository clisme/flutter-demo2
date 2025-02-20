import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '美团外卖点餐',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FoodOrderPage(),
    );
  }
}

class FoodOrderPage extends StatefulWidget {
  @override
  _FoodOrderPageState createState() => _FoodOrderPageState();
}

class _FoodOrderPageState extends State<FoodOrderPage> {
  final List<Map<String, dynamic>> categories = [
    {
      'name': '热销榜',
      'items': List.generate(10, (i) => {'name': '热销商品${i + 1}', 'price': 25 + i, 'image': 'https://picsum.photos/100/100?random=$i'})
    },
    {
      'name': '折扣套餐',
      'items': List.generate(8, (i) => {'name': '套餐${i + 1}', 'price': 40 + i*5, 'image': 'https://picsum.photos/100/100?random=${10+i}'})
    },
    {
      'name': '饮料甜品',
      'items': List.generate(6, (i) => {'name': '饮品${i + 1}', 'price': 10 + i*2, 'image': 'https://picsum.photos/100/100?random=${20+i}'})
    },
    {
      'name': '小吃炸物',
      'items': List.generate(12, (i) => {'name': '小吃${i + 1}', 'price': 15 + i, 'image': 'https://picsum.photos/100/100?random=${30+i}'})
    },
  ];

  late List<int> categoryOffsets;
  final ScrollController _scrollController = ScrollController();
  final double _estimatedItemHeight = 120.0;
  int _selectedCategoryIndex = 0;
  bool _isManualScroll = false;

  @override
  void initState() {
    super.initState();
    _buildCategoryOffsets();
    _scrollController.addListener(_handleScroll);
  }

  void _buildCategoryOffsets() {
    categoryOffsets = [];
     int offset = 0;
    for (var category in categories) {
      categoryOffsets.add(offset);
     offset += (category['items'] as List).length; // 使用 as List 强制类型转换
    }
    categoryOffsets.add(offset); // 添加最后边界
  }

  void _handleScroll() {
    if (_isManualScroll) return;
    
    final scrollOffset = _scrollController.offset;
    final currentIndex = (scrollOffset / _estimatedItemHeight).clamp(0, categoryOffsets.last - 1).floor();
    
    // 二分查找当前分类
    int low = 0;
    int high = categories.length;
    while (low < high) {
      final mid = (low + high) ~/ 2;
      if (categoryOffsets[mid] > currentIndex) {
        high = mid;
      } else {
        low = mid + 1;
      }
    }
    
    final newIndex = (low - 1).clamp(0, categories.length - 1);
    if (newIndex != _selectedCategoryIndex) {
      setState(() => _selectedCategoryIndex = newIndex);
    }
  }

  void _scrollToCategory(int index) {
    if (index < 0 || index >= categories.length) return;
    
    _isManualScroll = true;
    final position = categoryOffsets[index] * _estimatedItemHeight;
    _scrollController.animateTo(
      position.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    ).then((_) =>  setState(() {
        _selectedCategoryIndex = index; // 更新左侧菜单选中状态
        _isManualScroll = false;
      }));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          // 左侧分类菜单
          Container(
            width: 100,
            color: Colors.grey[100],
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) => _buildCategoryItem(index),
            ),
          ),
          // 右侧商品列表
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(8),
          itemCount: categories.fold<int>(0, (sum, category) => sum + (category['items']?.length as int )),
              itemBuilder: (context, index) => _buildProductItem(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
    return InkWell(
      onTap: () => _scrollToCategory(index),
      child: Container(
        height: 60,
        color: _selectedCategoryIndex == index ? Colors.white : Colors.grey[100],
        alignment: Alignment.center,
        child: Text(
          categories[index]['name'],
          style: TextStyle(
            color: _selectedCategoryIndex == index ? Colors.orange : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(int index) {
    // 找到对应的分类
    int categoryIndex = 0;
    for (int i = 0; i < categoryOffsets.length - 1; i++) {
      if (index >= categoryOffsets[i] && index < categoryOffsets[i + 1]) {
        categoryIndex = i;
        break;
      }
    }
    
    final item = categories[categoryIndex]['items'][index - categoryOffsets[categoryIndex]];
    
    return Container(
      height: 120,
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),)
        ],
      ),
      child: Row(
        children: [
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '¥${item['price']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.orange),
            onPressed: () => print('添加 ${item['name']}'),
          ),
        ],
      ),
    );
  }
}