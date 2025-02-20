import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '微信朋友圈',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: MomentsPage(),
    );
  }
}

class MomentsPage extends StatefulWidget {
  @override
  _MomentsPageState createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
  final List<Map<String, dynamic>> moments = [
    {
      'avatar': 'https://picsum.photos/50/50?random=1',
      'username': '用户1',
      'time': DateTime.now().subtract(Duration(days: 1)),
      'content': '这是朋友圈动态内容。',
      'images': [
        'https://picsum.photos/200/200?random=1',
        'https://picsum.photos/200/200?random=2',
        'https://picsum.photos/200/200?random=3',
        'https://picsum.photos/200/200?random=4',
        'https://picsum.photos/200/200?random=5',
        'https://picsum.photos/200/200?random=6',
        'https://picsum.photos/200/200?random=7',
        'https://picsum.photos/200/200?random=8',
        'https://picsum.photos/200/200?random=9',
        'https://picsum.photos/200/200?random=10',
      ],
      'location': '上海',
      'likes': 3,
      'liked': false,
      'likeUsers': ['用户A', '用户B', '用户C'],
      'comments': [
        {
          'username': '评论用户1',
          'comment': '这是评论内容1。',
          'time': DateTime.now().subtract(Duration(hours: 1)),
        },
        {
          'username': '评论用户2',
          'comment': '这是评论内容2。',
          'time': DateTime.now().subtract(Duration(hours: 2)),
        },
      ],
    },
    {
      'avatar': 'https://picsum.photos/50/50?random=2',
      'username': '用户2',
      'time': DateTime.now().subtract(Duration(hours: 5)),
      'content': '这是另一个朋友圈动态内容。',
      'images': [
        'https://picsum.photos/200/200?random=11',
      ],
      'location': '北京',
      'likes': 2,
      'liked': false,
      'likeUsers': ['用户D', '用户E'],
      'comments': [],
    },
    // 添加更多动态
  ];

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

  void _toggleLike(Map<String, dynamic> moment) {
    setState(() {
      if (moment['liked']) {
        moment['likes']--;
        moment['likeUsers'].remove('当前用户');
      } else {
        moment['likes']++;
        moment['likeUsers'].add('当前用户');
      }
      moment['liked'] = !moment['liked'];
    });
  }

  void _showCommentDialog(int index) {
    final TextEditingController _commentController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('评论 ${moments[index]['username']}'),
          content: TextField(
            controller: _commentController,
            decoration: InputDecoration(hintText: '输入评论内容'),
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
                  moments[index]['comments'].add({
                    'username': '当前用户',
                    'comment': _commentController.text,
                    'time': DateTime.now(),
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('评论'),
            ),
          ],
        );
      },
    );
  }

  void _showImageGallery(BuildContext context, List<String> images, int initialIndex) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: ImageGalleryPage(images: images, initialIndex: initialIndex),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('朋友圈'),
      ),
      body: ListView.builder(
        itemCount: moments.length,
        itemBuilder: (context, index) {
          final moment = moments[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(moment['avatar']),
                    ),
                    title: Text(moment['username']),
                    subtitle: Text(_formatTime(moment['time'])),
                  ),
                  Text(moment['content']),
                  SizedBox(height: 8.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: moment['images'].take(9).map<Widget>((image) {
                      int imageIndex = moment['images'].indexOf(image);
                      return GestureDetector(
                        onTap: () => _showImageGallery(context, moment['images'], imageIndex),
                        child: Image.network(image, width: 100, height: 100, fit: BoxFit.cover),
                      );
                    }).toList(),
                  ),
                  if (moment['location'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey, size: 16),
                          SizedBox(width: 4),
                          Text(moment['location'], style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: moment['liked'] ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => _toggleLike(moment),
                      ),
                      Text(moment['likes'].toString()),
                      IconButton(
                        icon: Icon(Icons.comment, color: Colors.grey),
                        onPressed: () => _showCommentDialog(index),
                      ),
                    ],
                  ),
                  if (moment['likeUsers'].isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Icon(Icons.favorite, color: Colors.red, size: 16),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              moment['likeUsers'].join(', '),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: moment['comments'].map<Widget>((comment) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${comment['username']}: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(child: Text(comment['comment'])),
                            Text(
                              _formatTime(comment['time']),
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageGalleryPage extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  ImageGalleryPage({required this.images, required this.initialIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            Navigator.of(context).pop();
          }
        },
        child: PhotoViewGallery.builder(
          itemCount: images.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(images[index]),
              initialScale: PhotoViewComputedScale.contained,
              heroAttributes: PhotoViewHeroAttributes(tag: images[index]),
            );
          },
          pageController: PageController(initialPage: initialIndex),
          scrollPhysics: BouncingScrollPhysics(),
          backgroundDecoration: BoxDecoration(color: Colors.black),
        ),
      ),
    );
  }
}