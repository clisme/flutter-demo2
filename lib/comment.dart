import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '长篇大论',
      theme: ThemeData.dark(),
      home: MusicPlayerPage(),
    );
  }
}

class MusicPlayerPage extends StatefulWidget {
  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('音乐播放器'),
        actions: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: '最新'),
              Tab(text: '最热'),
              Tab(text: '最有料'),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CommentsPage(type: '最新'),
          CommentsPage(type: '最热'),
          CommentsPage(type: '最有料'),
        ],
      ),
    );
  }
}

class CommentsPage extends StatefulWidget {
  final String type;

  CommentsPage({required this.type});

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final List<Map<String, dynamic>> comments = [
    {
      'avatar': 'https://picsum.photos/50/50',
      'username': '用户1',
      'comment': '这是评论内容。的的的的的的的的的的的的的的的的的的的的的的的的的的的的的的的的的的的的 ',
      'likes': 10,
      'liked': false,
      'time': DateTime.now().subtract(Duration(days: 2)),
      'ip': '上海',
      'vip': Random().nextBool(),
      'replies': [
        {
          'avatar': 'https://picsum.photos/30/30',
          'username': '回复用户1',
          'reply': '这是回复内容1。嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯嗯',
          'time': DateTime.now().subtract(Duration(hours: 1)),
          'ip': '广州',
          'likes': 5,
          'liked': false,
          'vip': Random().nextBool(),
        },
        {
          'avatar': 'https://picsum.photos/30/30',
          'username': '回复用户2',
          'reply': '这是回复内容2。',
          'time': DateTime.now().subtract(Duration(hours: 2)),
          'ip': '深圳',
          'likes': 3,
          'liked': false,
          'vip': Random().nextBool(),
        },
        // 添加更多回复
      ],
    },
    {
      'avatar': 'https://picsum.photos/50/50',
      'username': '用户2',
      'comment': '这是另一个评论内容。',
      'likes': 20,
      'liked': false,
      'time': DateTime.now().subtract(Duration(hours: 5)),
      'ip': '北京',
      'vip': Random().nextBool(),
      'replies': [],
    },
    // 添加更多评论
  ];

  void _showReplyDialog(int index) {
    final TextEditingController _replyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('回复 ${comments[index]['username']}'),
          content: TextField(
            controller: _replyController,
            decoration: InputDecoration(hintText: '输入回复内容'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  comments[index]['replies'].add({
                    'avatar': 'https://picsum.photos/30/30',
                    'username': '回复用户',
                    'reply': _replyController.text,
                    'time': DateTime.now(),
                    'ip': '广州',
                    'likes': 0,
                    'liked': false,
                    'vip': Random().nextBool(),
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('回复'),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 1) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 1) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }

  void _toggleLike(Map<String, dynamic> item) {
    setState(() {
      if (item['liked']) {
        item['likes']--;
      } else {
        item['likes']++;
      }
      item['liked'] = !item['liked'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(comment['avatar']),
              ),
              title: Row(
                children: [
                  Text(comment['username']),
                  if (comment['vip'])
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Icon(Icons.star, color: Colors.yellow, size: 16),
                    ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment['comment']),
                  SizedBox(height: 4),
                  Text(
                    '${_formatTime(comment['time'])} · ${comment['ip']}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      size: 16,
                      color: comment['liked'] ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => _toggleLike(comment),
                  ),
                  SizedBox(width: 4),
                  Text(comment['likes'].toString()),
                ],
              ),
              onTap: () => _showReplyDialog(index),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 72.0),
              child: comment['replies'].length > 5
                  ? ExpansionTile(
                      title: Text(
                        '展开${comment['replies'].length}条回复',
                        style: TextStyle(color: Colors.blue),
                      ),
                      children: comment['replies'].map<Widget>((reply) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(reply['avatar']),
                                radius: 15,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          reply['username'],
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        if (reply['vip'])
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Icon(Icons.star, color: Colors.yellow, size: 16),
                                          ),
                                      ],
                                    ),
                                    Text(reply['reply']),
                                    SizedBox(height: 4),
                                    Text(
                                      '${_formatTime(reply['time'])} · ${reply['ip']}',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.thumb_up,
                                            size: 16,
                                            color: reply['liked'] ? Colors.red : Colors.grey,
                                          ),
                                          onPressed: () => _toggleLike(reply),
                                        ),
                                        SizedBox(width: 4),
                                        Text(reply['likes'].toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: comment['replies'].map<Widget>((reply) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(reply['avatar']),
                                radius: 15,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          reply['username'],
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        if (reply['vip'])
                                          Padding(
                                            padding: const EdgeInsets.only(left: 4.0),
                                            child: Icon(Icons.star, color: Colors.yellow, size: 16),
                                          ),
                                      ],
                                    ),
                                    Text(reply['reply']),
                                    SizedBox(height: 4),
                                    Text(
                                      '${_formatTime(reply['time'])} · ${reply['ip']}',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.thumb_up,
                                            size: 16,
                                            color: reply['liked'] ? Colors.red : Colors.grey,
                                          ),
                                          onPressed: () => _toggleLike(reply),
                                        ),
                                        SizedBox(width: 4),
                                        Text(reply['likes'].toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        );
      },
    );
  }
}