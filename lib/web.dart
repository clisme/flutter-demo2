// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Three.js Animation in Flutter')),
//         body: SafeArea(child: ThreeJsWebView()),
//       ),
//     );
//   }
// }

// class ThreeJsWebView extends StatefulWidget {
//   @override
//   _ThreeJsWebViewState createState() => _ThreeJsWebViewState();
// }

// class _ThreeJsWebViewState extends State<ThreeJsWebView> {
//   late WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadFlutterAsset('assets/threejs_animation.html');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebViewWidget(controller: _controller);
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Three.js Animation in Flutter')),
//         body: SafeArea(child: ThreeJsWebView()),
//       ),
//     );
//   }
// }

// class ThreeJsWebView extends StatefulWidget {
//   @override
//   _ThreeJsWebViewState createState() => _ThreeJsWebViewState();
// }

// class _ThreeJsWebViewState extends State<ThreeJsWebView> {
//   late WebViewController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: 'https://threejs.org/examples/#webgl_animation_cloth',
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebViewCreated: (WebViewController webViewController) {
//         _controller = webViewController;
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:convert';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '3D动画示例',
//       home: Scaffold(
//         appBar: AppBar(title: Text('Three.js动画示例')),
//         body: ThreeJSAnimation(),
//       ),
//     );
//   }
// }

// class ThreeJSAnimation extends StatefulWidget {
//   @override
//   _ThreeJSAnimationState createState() => _ThreeJSAnimationState();
// }

// class _ThreeJSAnimationState extends State<ThreeJSAnimation> {
//   late WebViewController _controller;

//   final String _threeJSCode = '''
// <!DOCTYPE html>
// <html>
// <head>
//     <title>Three.js Demo</title>
//     <style> body { margin: 0; } </style>
// </head>
// <body>
//     <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
//     <script>
//         let scene, camera, renderer, cube;

//         function init() {
//             // 创建场景
//             scene = new THREE.Scene();
//             scene.background = new THREE.Color(0xffffff);

//             // 创建相机
//             camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
//             camera.position.z = 5;

//             // 创建渲染器
//             renderer = new THREE.WebGLRenderer({ antialias: true });
//             renderer.setSize(window.innerWidth, window.innerHeight);
//             document.body.appendChild(renderer.domElement);

//             // 创建立方体
//             const geometry = new THREE.BoxGeometry();
//             const material = new THREE.MeshPhongMaterial({ 
//                 color: 0x00ff00,
//                 specular: 0x111111,
//                 shininess: 200 
//             });
//             cube = new THREE.Mesh(geometry, material);
//             scene.add(cube);

//             // 添加灯光
//             const light = new THREE.DirectionalLight(0xffffff, 1);
//             light.position.set(0, 1, 1);
//             scene.add(light);

//             // 动画循环
//             function animate() {
//                 requestAnimationFrame(animate);
//                 cube.rotation.x += 0.01;
//                 cube.rotation.y += 0.01;
//                 renderer.render(scene, camera);
//             }
//             animate();

//             // 窗口大小变化处理
//             window.addEventListener('resize', onWindowResize, false);
//         }

//         function onWindowResize() {
//             camera.aspect = window.innerWidth / window.innerHeight;
//             camera.updateProjectionMatrix();
//             renderer.setSize(window.innerWidth, window.innerHeight);
//         }

//         // 接收Flutter消息
//         window.addEventListener('message', function(e) {
//             if(e.data === 'changeColor') {
//                 cube.material.color.setHex(Math.random() * 0xffffff);
//             }
//         });

//         init();
//     </script>
// </body>
// </html>
//   ''';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: WebView(
//             initialUrl: 'about:blank',
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (controller) {
//               _controller = controller;
//               _controller.loadUrl(Uri.dataFromString(_threeJSCode,
//                   mimeType: 'text/html',
//                   encoding: Encoding.getByName('utf-8')).toString());
//             },
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.all(10),
//           child: ElevatedButton(
//             child: Text('切换颜色'),
//             onPressed: () => _controller.evaluateJavascript(
//               "window.postMessage('changeColor', '*');"
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Three.js Animation in Flutter')),
//         body: SafeArea(child: ThreeJsWebView()),
//       ),
//     );
//   }
// }

// class ThreeJsWebView extends StatefulWidget {
//   @override
//   _ThreeJsWebViewState createState() => _ThreeJsWebViewState();
// }

// class _ThreeJsWebViewState extends State<ThreeJsWebView> {
//   late WebViewController _controller;
//   final String _threeJSCode = '''
// <!DOCTYPE html>
// <html>
// <head>
//   <meta charset="utf-8">
//   <title>Three.js Animation</title>
//   <style>
//     body { margin: 0; }
//     canvas { display: block; }
//   </style>
// </head>
// <body>
//   <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
//   <script>
//     var scene = new THREE.Scene();
//     var camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
//     var renderer = new THREE.WebGLRenderer();
//     renderer.setSize(window.innerWidth, window.innerHeight);
//     document.body.appendChild(renderer.domElement);

//     var geometry = new THREE.BoxGeometry();
//     var material = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
//     var cube = new THREE.Mesh(geometry, material);
//     scene.add(cube);

//     camera.position.z = 5;

//     var animate = function () {
//       requestAnimationFrame(animate);

//       cube.rotation.x += 0.01;
//       cube.rotation.y += 0.01;

//       renderer.render(scene, camera);
//     };

//     animate();

//     window.addEventListener('message', function(event) {
//       if (event.data === 'changeColor') {
//         cube.material.color.set(Math.random() * 0xffffff);
//       }
//     });
//   </script>
// </body>
// </html>
// ''';

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: WebView(
//             initialUrl: 'about:blank',
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (controller) {
//               _controller = controller;
//               _controller.loadUrl(Uri.dataFromString(_threeJSCode,
//                   mimeType: 'text/html',
//                   encoding: Encoding.getByName('utf-8')).toString());
//             },
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.all(10),
//           child: ElevatedButton(
//             child: Text('切换颜色'),
//             onPressed: () => _controller.runJavascript(
//               "window.postMessage('changeColor', '*');"
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }








// import 'package:flutter_three/flutter_three.dart';

// class Native3DScene extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Three(
//       renderer: THREE.WebGLRendererOptions(
//         antialias: true,
//       ),
//       onSceneCreated: (ThreeController controller) {
//         final scene = controller.scene;
//         final camera = controller.camera;
        
//         // 创建立方体
//         final geometry = THREE.BoxGeometry(1, 1, 1);
//         final material = THREE.MeshPhongMaterial(
//           color: THREE.Color.fromHex(0x00ff00),
//         );
//         final cube = THREE.Mesh(geometry, material);
//         scene.add(cube);
        
//         // 添加灯光
//         final light = THREE.DirectionalLight(0xffffff, 1);
//         light.position.setValues(0, 1, 1);
//         scene.add(light);
        
//         // 动画处理
//         controller.addAnimationCallback((delta) {
//           cube.rotation.x += 0.01;
//           cube.rotation.y += 0.01;
//         });
//       },
//     );
//   }
// }