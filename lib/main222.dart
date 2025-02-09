import 'package:flutter/material.dart';
import 'first_page.dart'; 
import 'second_page.dart';
import 'third_page.dart';
import 'video_page.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       routes: {
//         '/': (context) => FirstPage(
//              info: ModalRoute.of(context)?.settings.arguments as String),
//         '/second': (context) => SecondPage(
//             message: ModalRoute.of(context)?.settings.arguments as String)
//       },
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/video',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) {
              return FirstPage(info: args ?? 'Default Info');
            },
          );
        } else if (settings.name == '/second') {
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) {
              return SecondPage(message: args ?? 'Default Message');
            },
          );
        }
         else if (settings.name == '/third') {
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) {
              return ThirdPage(message: args ?? 'Default Message');
            },
          );
        }else if (settings.name == '/video') {
          final args = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) => VideoPage(message: args ?? 'Default Message'),
          );
        }
        // assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}

