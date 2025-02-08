import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TreeMenuExample(),
  ));
}


class TreeNode {
  final String label;
  final List<TreeNode>? children;
  bool expanded;

  TreeNode({required this.label, this.children, this.expanded = false});
}

// 主入口 无状态组件  定义数据
class TreeMenuExample extends StatelessWidget {
  final TreeNode root = TreeNode(
    label: 'Root',
    children: [
      TreeNode(label: 'Child 1', children: [
        TreeNode(label: 'Grandchild 1.1'),
        TreeNode(label: 'Grandchild 1.2'),
      ]),
      TreeNode(label: 'Child 2', children: [
        TreeNode(label: 'Grandchild 2.1'),
        TreeNode(label: 'Grandchild 2.2', children: [
          TreeNode(label: 'Great Grandchild 2.2.1'),
          TreeNode(label: 'Great Grandchild 2.2.2'),
        ]),
      ]),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('树形菜单示例'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TreeMenu(node: root),
      ),
    );
  }
}

// 创建有状态组件
class TreeMenu extends StatefulWidget {
  final TreeNode node;

  TreeMenu({required this.node});

  @override
  _TreeMenuState createState() => _TreeMenuState();
}


  // 具体实现
class _TreeMenuState extends State<TreeMenu> {
  late TreeNode currentNode;

  @override
  void initState() {
    super.initState();
    currentNode = widget.node;
  }

  void toggleExpand(TreeNode node) {
    setState(() {
      node.expanded = !node.expanded;
    });
  }

  Widget buildNode(TreeNode node) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(node.children != null && node.children!.isNotEmpty
              ? (node.expanded ? Icons.expand_more : Icons.arrow_right)
              : null),
          title: Text(node.label),
          onTap: () {
            if (node.children != null && node.children!.isNotEmpty) {
              toggleExpand(node);
            }
          },
        ),
        if (node.expanded && node.children != null && node.children!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: node.children!
                  .map((child) => TreeMenu(node: child))
                  .toList(),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildNode(currentNode);
  }
}