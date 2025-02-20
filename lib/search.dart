import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SearchPage in Flutter')),
        body: SafeArea(child: SearchPage()),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  List<String> suggestions = ['火锅', '烧烤', '奶茶', '蛋糕'];
  List<String> searchResults = ['火锅店A', '烧烤店B', '奶茶店C', '蛋糕店D'];
  List<String> searchHistory = ['火锅', '烧烤', '奶茶'];

  void _deleteHistoryItem(int index) {
    setState(() {
      searchHistory.removeAt(index);
    });
  }

  void _clearAllHistory() {
    setState(() {
      searchHistory.clear();
    });
  }

  void _addToHistory(String query) {
    if (query.isNotEmpty && !searchHistory.contains(query)) {
      setState(() {
        searchHistory.insert(0, query); // 将新搜索添加到历史记录的开头
      });
    }
  }

  void _clearSearch() {
    setState(() {
      searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '搜索商家、商品',
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('用户搜索了：');
                  },
                ),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close),
                        onPressed: _clearSearch,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              onSubmitted: (value) {
                _addToHistory(value); // 提交搜索时添加到历史记录
                print('用户搜索了：$value'); // 输出一句话
              },
              onTap: () {
                setState(() {
                  // 聚焦时显示搜索历史
                });
              },
            ),
          ),
          if (searchQuery.isEmpty && searchHistory.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '搜索历史',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: _clearAllHistory,
                    child: Text('清空历史'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView(
              children: [
                if (searchQuery.isEmpty)
                  ...searchHistory.asMap().entries.map((entry) {
                    int index = entry.key;
                    String history = entry.value;
                    return ListTile(
                      title: Text(history),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => _deleteHistoryItem(index),
                      ),
                      onTap: () {
                        setState(() {
                          searchQuery = history;
                          _searchController.text = history;
                        });
                      },
                    );
                  }),
                if (searchQuery.isNotEmpty)
                  ...suggestions
                      .where((suggestion) => suggestion.contains(searchQuery))
                      .map((suggestion) => ListTile(
                            title: Text(suggestion),
                            onTap: () {
                              setState(() {
                                searchQuery = suggestion;
                                _searchController.text = suggestion;
                              });
                            },
                          )),
                if (searchQuery.isNotEmpty)
                  ...searchResults
                      .where((result) => result.contains(searchQuery))
                      .map((result) => ListTile(
                            title: Text(result),
                            onTap: () {
                              // 处理用户选择结果
                            },
                          )),
                if (searchQuery.isNotEmpty &&
                    suggestions
                        .where((suggestion) => suggestion.contains(searchQuery))
                        .isEmpty &&
                    searchResults
                        .where((result) => result.contains(searchQuery))
                        .isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '未找到相关结果',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
