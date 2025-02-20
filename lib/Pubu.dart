import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// void main() {
//   runApp(MyApp());
// }

class Pubu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '瀑布流',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('瀑布流1'),
        // ),
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
  bool _hasMore = true;

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
    if (_isLoading || !_hasMore) return;

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
      if (_products.length >= 20) {
        _hasMore = false;
      }
    });
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _products.clear(); // 清空现有的商品列表
      _hasMore = true; // 重置加载更多标志
    });
    await _loadMoreProducts(); // 加载新的商品数据
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshProducts,
      child: StaggeredGridView.countBuilder(
        controller: _scrollController,
        crossAxisCount: 4,
        itemCount: _products.length + 1,
        itemBuilder: (context, index) {
          if (index == _products.length) {
            return Center(
              child: _hasMore && index != 0
                  ? CircularProgressIndicator()
                  : index == 0
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '全部加载完毕',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
            );
          }

          final product = _products[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImagePage(
                          imageUrl: product['image']!,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.grey[300], // 设置图片部分的背景色
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/result.png', // 占位符图片
                      image: product['image']!,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300], // 设置加载失败时的背景色
                          child: Image.asset('assets/images/result.png'),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product['name']!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    product['price']!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          );
        },
        staggeredTileBuilder: (index) => index == _products.length
            ? StaggeredTile.fit(4) // 确保加载指示器占据整个宽度
            : StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}


class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  FullScreenImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/result.png', // 占位符图片
            image: imageUrl,
            fit: BoxFit.contain,
            imageErrorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300], // 设置加载失败时的背景色
                child: Image.asset('assets/images/result.png'),
              );
            },
          ),
        ),
      ),
    );
  }
}
