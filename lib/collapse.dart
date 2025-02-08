import 'package:flutter/material.dart';

void main() {
//  print('Hello, World123!');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('折叠面板示例'),
        ),
        body: ExpansionPanelListDemo(),
      ),
    );
  }
}

class ExpansionPanelListDemo extends StatefulWidget {
  @override
  _ExpansionPanelListDemoState createState() => _ExpansionPanelListDemoState();
}

class _ExpansionPanelListDemoState extends State<ExpansionPanelListDemo> {
  List<bool> _isExpanded = [false, true]; // 使用列表来管理多个面板的状态

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // 添加内边距以避免内容紧贴边缘
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              color: const Color.fromARGB(255, 242, 228, 228),
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          _isExpanded[index] = !_isExpanded[index];
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text('面板1'),
                            );
                          },
                          body: ListTile(
                            title: Text('这是折叠面板的内容。你可以在这里添加更多的信息或控件。'),
                            subtitle: Text('点击面板标题可以展开或折叠内容。'),
                          ),
                          isExpanded: _isExpanded[0],
                        ),
                        ExpansionPanel(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text('面板2'),
                            );
                          },
                          body: ListTile(
                            title: Text('这是折叠面板的内容。你可以在这里添加更多的信息或控件。'),
                            subtitle: Text('点击面板标题可以展开或折叠内容。'),
                          ),
                          isExpanded: _isExpanded[1],
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('点击我展开/折叠'),
                      children: <Widget>[
                        Text('这是折叠面板的内容。'),
                        Text('点击标题可以展开或折叠这部分内容。'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
