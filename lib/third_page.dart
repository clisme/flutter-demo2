import 'package:flutter/material.dart';
import 'first_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ThirdPage extends StatefulWidget {
  final String message;

  // 构造函数接收参数
  ThirdPage({required this.message});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  dynamic data;
  List<dynamic> data1 = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    var response = await http.get(
      Uri.parse(
          'http://192.168.199.72:9081/dit-admin/question/questionnaire/page?limit=8&page=1'),
      headers: {
        'token': '1067246875800000001',
        'Accept-Charset': 'utf-8'
      },
    );

    print(response.statusCode);

    // if (response.statusCode == 200) {
    //     //  var decodedResponse = utf8.decode(response.body as List<int>);
    //   data = jsonDecode(response.body); // 假设服务器返回的数据结构中有'data'字段
    //   isLoading = false;
    //  print('Data: $data, Code: 7777'); 
    //   setState(() {
    //      data1 = data['data']['list'];
    //   });

    //   print(data1);
    //   print(223355);
    // }

    try {
     
       data = jsonDecode(response.body);
print('Data: $data, Code: 7777');


  utf8.decode(data['data']['list']);
  for (var element in data['data']['list']) {
  // 假设 element 是一个 Map，包含 'objectName' 字段
  if (element is Map<String, dynamic> && element['objectName'] is String) {
  
    print(element['objectName']);
  } else {
    print('Element is not a Map: $element');
  }
}

        // 假设服务器返回的数据结构中有'data'字段和'list'字段
        if (data['data'] != null && data['data']['list'] != null) {
          setState(() {
            data1 =data['data']['list'] ;
          });
        } else {
          print('Data structure is not as expected');
        }

        print(data1);
        print(223355);
      } catch (e) {
        print('Error decoding JSON: $e');
        isLoading = false;
      }

    // if (response.statusCode == 200) {
    //   setState(() {
    //     data = jsonDecode(response.body)['data']; // 假设服务器返回的数据结构中有'data'字段
    //     isLoading = false;
    //   });
    //   print(data);
    // } else {
    //   throw Exception('Failed to load data');
    // }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // fetchData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Received message:'),
            Text(
              widget.message,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // if (isLoading )
            //   CircularProgressIndicator()
            // else
            Expanded(
              child: ListView.builder(
                itemCount: data1.length,
                itemBuilder: (context, index) {
                  final item = data1[index];
                  return ListTile(
                    title: Text(item['objectName']), // 仅展示 name 字段
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FirstPage(info: 'Hello from 3 Page!'),
                  ),
                );
              },
              child: Text('Go back to First Page'),
            ),
          ],
        ),
      ),
    );
  }
}
