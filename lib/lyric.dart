// 1.0.0

// import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// import 'dart:ui'; // 添加这一行

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '音乐播放器',
//       theme: ThemeData.dark(),
//       home: MusicPlayerPage(),
//     );
//   }
// }

// class MusicPlayerPage extends StatefulWidget {
//   @override
//   _MusicPlayerPageState createState() => _MusicPlayerPageState();
// }

// class _MusicPlayerPageState extends State<MusicPlayerPage> {
//   final String lrcLyrics = '''
// [00:00.00] 作词 : 方文山
// [00:01.00] 作曲 : 周杰伦
// [00:02.00] 编曲 : 钟兴民
// [00:20.05]素胚勾勒出青花笔锋浓转淡
// [00:24.01]瓶身描绘的牡丹一如你初妆
// [00:27.95]冉冉檀香透过窗心事我了然
// [00:32.00]宣纸上走笔至此搁一半
// ''';

//   List<LyricLine> lyrics = [];
//   double _currentPosition = 0.0;
//   bool _showLyrics = false;
//   bool _isPlaying = true;
//   Duration _currentTime = Duration.zero;
//   final Duration _songDuration = Duration(minutes: 3, seconds: 30);
//   final ScrollController _lyricScrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _parseLyrics();
//     _startPlaybackSimulation();
//   }

//   void _parseLyrics() {
//     lyrics = lrcLyrics.split('\n').where((line) {
//       return line.contains(']') && line.indexOf(']') > 0;
//     }).map((line) {
//       final timePart = line.substring(1, line.indexOf(']'));
//       final text = line.substring(line.indexOf(']') + 1).trim();
//       final minutes = double.parse(timePart.split(':')[0]);
//       final seconds = double.parse(timePart.split(':')[1]);
//       return LyricLine(
//         time: Duration(
//           minutes: minutes.toInt(),
//           milliseconds: (seconds * 1000).toInt(),
//         ),
//         text: text,
//       );
//     }).toList();
//   }

//   void _startPlaybackSimulation() {
//     if (_isPlaying) {
//       Future.delayed(Duration(seconds: 1), () {
//         if (_isPlaying) {
//           setState(() {
//             _currentTime += Duration(seconds: 1);
//             _currentPosition = _currentTime.inMilliseconds /
//                 _songDuration.inMilliseconds;

//             // 自动滚动歌词
//             final currentLine = lyrics.lastWhere(
//               (line) => line.time <= _currentTime,
//               orElse: () => lyrics.first,
//             );
//             final index = lyrics.indexOf(currentLine);
//             if (index != -1) {
//               _lyricScrollController.animateTo(
//                 index * 60.0,
//                 duration: Duration(milliseconds: 300),
//                 curve: Curves.easeOut,
//               );
//             }
//           });
//           _startPlaybackSimulation();
//         }
//       });
//     }
//   }

//   int _findCurrentLyricIndex() {
//     return lyrics.lastIndexWhere(
//       (line) => line.time <= _currentTime,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => setState(() => _showLyrics = !_showLyrics),
//         child: Stack(
//           children: [
//             // 背景墙
//             _buildBackground(),
//             // 歌词界面
//             if (_showLyrics) _buildLyricsInterface(),
//             // 控制栏
//             _buildControlBar(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBackground() {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 500),
//       child: Container(
//         key: ValueKey(_showLyrics),
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: NetworkImage(
//               'https://picsum.photos/800/1200?random=music'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//           child: Container(
//             color: Colors.black.withOpacity(0.3),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLyricsInterface() {
//     final currentIndex = _findCurrentLyricIndex();

//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 60),
//       child: ListView.builder(
//         controller: _lyricScrollController,
//         itemCount: lyrics.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//             child: Text(
//               lyrics[index].text,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: currentIndex == index ? 24 : 20,
//                 color: currentIndex == index ?
//                     Colors.white : Colors.white.withOpacity(0.6),
//                 fontWeight: currentIndex == index ?
//                     FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildControlBar() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         height: 160,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.transparent,
//               Colors.black.withOpacity(0.8),
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             Slider(
//               value: _currentPosition,
//               onChanged: (value) {
//                 setState(() {
//                   _currentPosition = value;
//                   _currentTime = Duration(
//                     milliseconds: (value * _songDuration.inMilliseconds).toInt(),
//                   );
//                 });
//               },
//               activeColor: Colors.white,
//               inactiveColor: Colors.white30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.skip_previous, size: 32),
//                   onPressed: () {},
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
//                     size: 48,
//                   ),
//                   onPressed: () {
//                     setState(() => _isPlaying = !_isPlaying);
//                     if (_isPlaying) _startPlaybackSimulation();
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.skip_next, size: 32),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LyricLine {
//   final Duration time;
//   final String text;

//   LyricLine({required this.time, required this.text});
// }

// 1.2.0

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '音乐播放器示例',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MusicPlayerPage(),
//     );
//   }
// }

// class MusicPlayerPage extends StatefulWidget {
//   @override
//   _MusicPlayerPageState createState() => _MusicPlayerPageState();
// }

// class _MusicPlayerPageState extends State<MusicPlayerPage> {
//   bool _isPlaying = false;
//   Duration _currentPosition = Duration.zero;
//   Duration _totalDuration = Duration(minutes: 3); // 假设歌曲总时长为3分钟
//   List<LyricLine> _lyrics = [
//     LyricLine(time: Duration(seconds: 0), text: "歌词1"),
//     LyricLine(time: Duration(seconds: 30), text: "歌词2"),
//     LyricLine(time: Duration(seconds: 60), text: "歌词3"),
//     LyricLine(time: Duration(seconds: 90), text: "歌词4"),
//     LyricLine(time: Duration(seconds: 120), text: "歌词5"),
//     LyricLine(time: Duration(seconds: 150), text: "歌词6"),
//   ];

//   void _startPlaybackSimulation() {
//     Future.delayed(Duration(seconds: 1), () {
//       if (_isPlaying) {
//         setState(() {
//           _currentPosition += Duration(seconds: 1);
//           if (_currentPosition >= _totalDuration) {
//             _isPlaying = false;
//             _currentPosition = _totalDuration;
//           } else {
//             _startPlaybackSimulation();
//           }
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('音乐播放器示例'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               '当前时间: ${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
//               style: TextStyle(fontSize: 24),
//             ),
//             Text(
//               '总时长: ${_totalDuration.inMinutes}:${(_totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
//               style: TextStyle(fontSize: 24),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _lyrics.length,
//                 itemBuilder: (context, index) {
//                   final lyric = _lyrics[index];
//                   return ListTile(
//                     title: Text(
//                       lyric.text,
//                       style: TextStyle(
//                         color: _currentPosition >= lyric.time
//                             ? Colors.blue
//                             : Colors.black,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     _isPlaying
//                         ? Icons.pause_circle_filled
//                         : Icons.play_circle_filled,
//                     size: 48,
//                   ),
//                   onPressed: () {
//                     setState(() => _isPlaying = !_isPlaying);
//                     if (_isPlaying) {
//                       _startPlaybackSimulation();
//                     }
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.skip_next, size: 32),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LyricLine {
//   final Duration time;
//   final String text;

//   LyricLine({required this.time, required this.text});
// }

// 1.3.0

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '音乐播放器示例',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MusicPlayerPage(),
//     );
//   }
// }

// class MusicPlayerPage extends StatefulWidget {
//   @override
//   _MusicPlayerPageState createState() => _MusicPlayerPageState();
// }

// class _MusicPlayerPageState extends State<MusicPlayerPage> {
//   bool _isPlaying = false;
//   bool _showLyrics = false;
//   Duration _currentPosition = Duration.zero;
//   Duration _totalDuration = Duration(minutes: 3); // 假设歌曲总时长为3分钟
//   List<LyricLine> _lyrics = [
//     LyricLine(time: Duration(seconds: 0), text: "歌词1"),
//     LyricLine(time: Duration(seconds: 10), text: "歌词2"),
//     LyricLine(time: Duration(seconds: 20), text: "歌词3"),
//     LyricLine(time: Duration(seconds: 30), text: "歌词4"),
//     LyricLine(time: Duration(seconds: 40), text: "歌词5"),
//     LyricLine(time: Duration(seconds: 50), text: "歌词6"),
//     LyricLine(time: Duration(seconds: 60), text: "歌词7"),
//     LyricLine(time: Duration(seconds: 70), text: "歌词8"),
//     LyricLine(time: Duration(seconds: 80), text: "歌词9"),
//     LyricLine(time: Duration(seconds: 90), text: "歌词10"),
//     LyricLine(time: Duration(seconds: 100), text: "歌词11"),
//     LyricLine(time: Duration(seconds: 110), text: "歌词12"),
//     LyricLine(time: Duration(seconds: 120), text: "歌词13"),
//     LyricLine(time: Duration(seconds: 130), text: "歌词14"),
//     LyricLine(time: Duration(seconds: 140), text: "歌词15"),
//     LyricLine(time: Duration(seconds: 150), text: "歌词16"),
//     LyricLine(time: Duration(seconds: 160), text: "歌词17"),
//     LyricLine(time: Duration(seconds: 170), text: "歌词18"),
//     LyricLine(time: Duration(seconds: 180), text: "歌词19"),
//   ];

//   ScrollController _scrollController = ScrollController();

//   void _startPlaybackSimulation() {
//     Future.delayed(Duration(seconds: 1), () {
//       if (_isPlaying) {
//         setState(() {
//           _currentPosition += Duration(seconds: 1);
//           if (_currentPosition >= _totalDuration) {
//             _isPlaying = false;
//             _currentPosition = _totalDuration;
//           } else {
//             _startPlaybackSimulation();
//           }
//         });
//         _scrollToCurrentLyric();
//       }
//     });
//   }

//   void _scrollToCurrentLyric() {
//     int currentIndex = _lyrics.indexWhere((lyric) => _currentPosition < lyric.time);
//     if (currentIndex == -1) {
//       currentIndex = _lyrics.length - 1;
//     } else if (currentIndex > 0) {
//       currentIndex -= 1;
//     }
//     double offset = currentIndex * 48.0 - (MediaQuery.of(context).size.height / 2) + 24.0;
//     _scrollController.animateTo(
//       offset,
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GestureDetector(
//             onTap: () {
//               setState(() {
//                 _showLyrics = !_showLyrics;
//               });
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage('https://picsum.photos/800/800'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: _showLyrics
//                   ? Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: ListView.builder(
//                             controller: _scrollController,
//                             itemCount: _lyrics.length,
//                             itemBuilder: (context, index) {
//                               final lyric = _lyrics[index];
//                               final isCurrent = _currentPosition >= lyric.time &&
//                                   (index == _lyrics.length - 1 ||
//                                       _currentPosition < _lyrics[index + 1].time);
//                               return Center(
//                                 child: Container(
//                                   height: 48.0,
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     lyric.text,
//                                     style: TextStyle(
//                                       color: isCurrent
//                                           ? Colors.blue
//                                           : _currentPosition >= lyric.time
//                                               ? Colors.white.withOpacity(0.5)
//                                               : Colors.white.withOpacity(0.5),
//                                       fontSize: isCurrent ? 24 : 18,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   : Center(
//                       child: Text(
//                         '点击显示歌词',
//                         style: TextStyle(fontSize: 24, color: Colors.white),
//                       ),
//                     ),
//             ),
//           ),
//           Positioned(
//             bottom: 50,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 Slider(
//                   value: _currentPosition.inSeconds.toDouble(),
//                   min: 0,
//                   max: _totalDuration.inSeconds.toDouble(),
//                   onChanged: (value) {
//                     setState(() {
//                       _currentPosition = Duration(seconds: value.toInt());
//                       _scrollToCurrentLyric();
//                     });
//                   },
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       Text(
//                         '${_totalDuration.inMinutes}:${(_totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       icon: Icon(
//                         _isPlaying
//                             ? Icons.pause_circle_filled
//                             : Icons.play_circle_filled,
//                         size: 48,
//                         color: Colors.white,
//                       ),
//                       onPressed: () {
//                         setState(() => _isPlaying = !_isPlaying);
//                         if (_isPlaying) {
//                           _startPlaybackSimulation();
//                         }
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.skip_next, size: 32, color: Colors.white),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class LyricLine {
//   final Duration time;
//   final String text;

//   LyricLine({required this.time, required this.text});
// }



// 1.4.0

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:ui';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '音乐播放器',
//       theme: ThemeData.dark(),
//       home: MusicPlayerPage(),
//     );
//   }
// }

// class MusicPlayerPage extends StatefulWidget {
//   @override
//   _MusicPlayerPageState createState() => _MusicPlayerPageState();
// }

// class _MusicPlayerPageState extends State<MusicPlayerPage> {
//   final String lrcLyrics = '''
// [00:00.00] 作词 : 方文山
// [00:01.00] 作曲 : 周杰伦
// [00:02.00] 编曲 : 钟兴民
// [00:20.05]素胚勾勒出青花笔锋浓转淡
// [00:24.01]瓶身描绘的牡丹一如你初妆
// [00:27.95]冉冉檀香透过窗心事我了然
// [00:32.00]宣纸上走笔至此搁一半
// ''';

//   List<LyricLine> lyrics = [];
//   double _currentPosition = 0.0;
//   bool _showLyrics = false;
//   bool _isPlaying = true;
//   Duration _currentTime = Duration.zero;
//   final Duration _songDuration = Duration(minutes: 3, seconds: 30);
//   final ScrollController _lyricScrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _parseLyrics();
//     _startPlaybackSimulation();
//   }

//   void _parseLyrics() {
//     lyrics = lrcLyrics.split('\n').where((line) {
//       return line.contains(']') && line.indexOf(']') > 0;
//     }).map((line) {
//       final timePart = line.substring(1, line.indexOf(']'));
//       final text = line.substring(line.indexOf(']') + 1).trim();
//       final minutes = double.parse(timePart.split(':')[0]);
//       final seconds = double.parse(timePart.split(':')[1]);
//       return LyricLine(
//         time: Duration(
//           minutes: minutes.toInt(),
//           milliseconds: (seconds * 1000).toInt(),
//         ),
//         text: text,
//       );
//     }).toList();
//   }

//   void _startPlaybackSimulation() {
//     if (_isPlaying) {
//       Future.delayed(Duration(seconds: 1), () {
//         if (_isPlaying) {
//           setState(() {
//             _currentTime += Duration(seconds: 1);
//             _currentPosition = _currentTime.inMilliseconds / 
//                 _songDuration.inMilliseconds;
            
//             // 自动滚动歌词
//             final currentLine = lyrics.lastWhere(
//               (line) => line.time <= _currentTime,
//               orElse: () => lyrics.first,
//             );
//             final index = lyrics.indexOf(currentLine);
//             if (index != -1) {
//               _scrollToCenter(index);
//             }
//           });
//           _startPlaybackSimulation();
//         }
//       });
//     }
//   }

//   int _findCurrentLyricIndex() {
//     return lyrics.lastIndexWhere(
//       (line) => line.time <= _currentTime,
//     );
//   }

//   void _scrollToCenter(int index) {
//     final itemHeight = 60.0; // 每一行的高度
//     final offset = index * itemHeight - (MediaQuery.of(context).size.height / 2) + (itemHeight / 2);
//     _lyricScrollController.animateTo(
//       offset.clamp(0.0, _lyricScrollController.position.maxScrollExtent),
//       duration: Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => setState(() => _showLyrics = !_showLyrics),
//         child: Stack(
//           children: [
//             // 背景墙
//             _buildBackground(),
//             // 歌词界面
//             if (_showLyrics) _buildLyricsInterface(),
//             // 控制栏
//             _buildControlBar(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBackground() {
//     return AnimatedSwitcher(
//       duration: Duration(milliseconds: 500),
//       child: Container(
//         key: ValueKey(_showLyrics),
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: NetworkImage(
//               'https://picsum.photos/800/1200?random=music'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//           child: Container(
//             color: Colors.black.withOpacity(0.3),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLyricsInterface() {
//     final currentIndex = _findCurrentLyricIndex();
    
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 60),
//       child: ListView.builder(
//         controller: _lyricScrollController,
//         itemCount: lyrics.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//             child: Text(
//               lyrics[index].text,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: currentIndex == index ? 24 : 20,
//                 color: currentIndex == index ? 
//                     Colors.white : Colors.white.withOpacity(0.6),
//                 fontWeight: currentIndex == index ? 
//                     FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildControlBar() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         height: 160,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.transparent,
//               Colors.black.withOpacity(0.8),
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             Slider(
//               value: _currentPosition,
//               onChanged: (value) {
//                 setState(() {
//                   _currentPosition = value;
//                   _currentTime = Duration(
//                     milliseconds: (value * _songDuration.inMilliseconds).toInt(),
//                   );
//                 });
//               },
//               activeColor: Colors.white,
//               inactiveColor: Colors.white30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.skip_previous, size: 32),
//                   onPressed: () {},
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
//                     size: 48,
//                   ),
//                   onPressed: () {
//                     setState(() => _isPlaying = !_isPlaying);
//                     if (_isPlaying) _startPlaybackSimulation();
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.skip_next, size: 32),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LyricLine {
//   final Duration time;
//   final String text;

//   LyricLine({required this.time, required this.text});
// }



// 1.5.0


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '音乐播放器示例',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MusicPlayerPage(),
    );
  }
}

class MusicPlayerPage extends StatefulWidget {
  @override
  _MusicPlayerPageState createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  bool _isPlaying = false;
  bool _showLyrics = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration(minutes: 3);
  List<LyricLine> _lyrics = [
    LyricLine(time: Duration(seconds: 0), text: "歌词1"),
    LyricLine(time: Duration(seconds: 10), text: "歌词2"),
    LyricLine(time: Duration(seconds: 20), text: "歌词3"),
    LyricLine(time: Duration(seconds: 30), text: "歌词4"),
    LyricLine(time: Duration(seconds: 40), text: "歌词5"),
    LyricLine(time: Duration(seconds: 50), text: "歌词6"),
    LyricLine(time: Duration(seconds: 60), text: "歌词7"),
    LyricLine(time: Duration(seconds: 70), text: "歌词8"),
    LyricLine(time: Duration(seconds: 80), text: "歌词9"),
    LyricLine(time: Duration(seconds: 90), text: "歌词10"),
    LyricLine(time: Duration(seconds: 100), text: "歌词11"),
    LyricLine(time: Duration(seconds: 110), text: "歌词12"),
    LyricLine(time: Duration(seconds: 120), text: "歌词13"),
    LyricLine(time: Duration(seconds: 130), text: "歌词14"),
    LyricLine(time: Duration(seconds: 140), text: "歌词15"),
    LyricLine(time: Duration(seconds: 150), text: "歌词16"),
    LyricLine(time: Duration(seconds: 160), text: "歌词17"),
    LyricLine(time: Duration(seconds: 170), text: "歌词18"),
    LyricLine(time: Duration(seconds: 180), text: "歌词19"),
  ];

  late ScrollController _scrollController;
  final double _lyricLineHeight = 48.0;
  late double _screenHeight;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _screenHeight = MediaQuery.of(context).size.height;
    });
  }

  void _startPlaybackSimulation() {
    Future.delayed(Duration(seconds: 1), () {
      if (_isPlaying) {
        setState(() {
          _currentPosition += Duration(seconds: 1);
          if (_currentPosition >= _totalDuration) {
            _isPlaying = false;
            _currentPosition = _totalDuration;
          } else {
            _startPlaybackSimulation();
          }
        });
        _scrollToCurrentLyric();
      }
    });
  }

  void _scrollToCurrentLyric() {
    final currentIndex = _findCurrentLyricIndex();
    final paddingOffset = (_screenHeight / 2 - _lyricLineHeight / 2);
    final scrollOffset = currentIndex * _lyricLineHeight - paddingOffset;

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  int _findCurrentLyricIndex() {
    for (int i = _lyrics.length - 1; i >= 0; i--) {
      if (_currentPosition >= _lyrics[i].time) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _showLyrics = !_showLyrics;
                if (_showLyrics) _scrollToCurrentLyric();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://picsum.photos/800/800'),
                  fit: BoxFit.cover,
                ),
              ),
              child: _showLyrics
                  ? _buildLyricsList()
                  : Center(
                      child: Text(
                        '点击显示歌词',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
            ),
          ),
          _buildControlBar(),
        ],
      ),
    );
  }

  Widget _buildLyricsList() {
    return ListView.builder(
      controller: _scrollController,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _lyrics.length,
      itemBuilder: (context, index) {
        final lyric = _lyrics[index];
        final isCurrent = index == _findCurrentLyricIndex();
        final isPassed = index < _findCurrentLyricIndex();
        
        return Container(
          height: _lyricLineHeight,
          alignment: Alignment.center,
          child: AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 300),
            style: TextStyle(
              color: isCurrent 
                  ? Colors.white 
                  : Colors.white.withOpacity(isPassed ? 0.3 : 0.6),
              fontSize: isCurrent ? 24 : 18,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(lyric.text),
          ),
        );
      },
    );
  }

  Widget _buildControlBar() {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Slider(
            value: _currentPosition.inSeconds.toDouble(),
            min: 0,
            max: _totalDuration.inSeconds.toDouble(),
            onChanged: (value) {
              setState(() {
                _currentPosition = Duration(seconds: value.toInt());
                _scrollToCurrentLyric();
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '${_totalDuration.inMinutes}:${(_totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                  size: 48,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() => _isPlaying = !_isPlaying);
                  if (_isPlaying) _startPlaybackSimulation();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LyricLine {
  final Duration time;
  final String text;

  LyricLine({required this.time, required this.text});
}
