import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '懒加载商品列表',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('懒加载商品列表示例'),
        ),
        body: ProductList(),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<Map<String, String>> _products = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMoreProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // 模拟网络请求延迟
    await Future.delayed(Duration(seconds: 2));

    List<Map<String, String>> newProducts = List.generate(10, (index) {
      int productIndex = _products.length + index + 1;
      return {
        'image': 'https://picsum.photos/200/200?random=$productIndex',
        'name': '商品 $productIndex',
        'price': '\$${(productIndex * 10).toString()}',
      };
    });

    setState(() {
      _products.addAll(newProducts);
      _isLoading = false;
    });
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _products.clear(); // 清空现有的商品列表
    });
    await _loadMoreProducts(); // 加载新的商品数据
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshProducts,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _products.length + 1,
        itemBuilder: (context, index) {
          if (index == _products.length) {
            return _isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox.shrink();
          }

          final product = _products[index];
          return ListTile(
            leading: Container(
              color: Colors.grey[300], // 设置图片部分的背景色
              child: Image.network(
                product['image']!,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(product['name']!),
            subtitle: Text(product['price']!),
          );
        },
      ),
    );
  }
}
