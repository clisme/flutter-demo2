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
          title: Text('多选组示例'),
        ),
        body: CheckboxGroupExample(),
      ),
    );
  }
}

class CheckboxGroupExample extends StatefulWidget {
  @override
  _CheckboxGroupExampleState createState() => _CheckboxGroupExampleState();
}

class _CheckboxGroupExampleState extends State<CheckboxGroupExample> {
  final List<String> _options = ['选项 1', '选项 2', '选项 3', '选项 4'];
  final Set<String> _selectedOptions = {};

  void _handleCheckedChanged(String value, bool isChecked) {
    setState(() {
      if (isChecked) {
        _selectedOptions.add(value);
        print('添加: $_selectedOptions');
      } else {
        _selectedOptions.remove(value);
          print('yi: $_selectedOptions');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _options.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          title: Text(_options[index]),
          value: _selectedOptions.contains(_options[index]),
          onChanged: (value) {
            _handleCheckedChanged(_options[index], value!);
          },
          controlAffinity: ListTileControlAffinity.leading, // Checkbox 在文本左侧
        );
      },
    );
  }
}
