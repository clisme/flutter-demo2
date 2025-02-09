import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
// import 'package:carousel_slider/carousel_controller.dart' as carousel_controller;

// void main() => runApp(const VideoPage());

class VideoPage extends StatelessWidget {
  final String message;
  const VideoPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // Once the video has been loaded, use the first frame to provide a preview.
      //  setState(() {
      //       // 确保视频初始化完成后开始播放
      //       _controller.play();
      //     });

      // 确保视频初始化完成后开始播放
      _controller.play();
    });

    // Use the controller to loop the video.
    _controller.setLooping(true);

    //  _controller.play();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Column(children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              print(_controller.value.aspectRatio);
              print(11133);
              // _controller.play();
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        SizedBox(height: 20),
        Text('123')
        // carousel_slider.CarouselSlider(
        //     options: carousel_slider.CarouselOptions(height: 200.0, autoPlay: true),
        //     items: [1, 2, 3, 4, 5].map((i) {
        //       return Builder(
        //         builder: (BuildContext context) {
        //           return Container(
        //             width: MediaQuery.of(context).size.width,
        //             margin: EdgeInsets.symmetric(horizontal: 5.0),
        //             decoration: BoxDecoration(color: Colors.amber),
        //             child: Text(
        //               'text $i',
        //               style: TextStyle(fontSize: 16.0),
        //             ),
        //           );
        //         },
        //       );
        //     }).toList(),
        //   ),
      ]),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
