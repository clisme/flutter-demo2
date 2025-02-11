import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form Example'),
        ),
        body: FormExample(),
      ),
    );
  }
}

class FormExample extends StatefulWidget {
  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedRadio;
  List<String> _selectedCheckboxes = [];
  bool _switchValue = false;
  TextEditingController _textController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        print(_selectedDate);
        print(156);
      });
    }
  }

  // String _selectCheckbox(dynamic value) {
  //   print(556655);
  //   print(value);
  //   var value1 = value.toString().split(' ')[0];
  //   // return '2025-02-10';
  //   return value1;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            // 日期选择
            ListTile(
              title: Text(_selectedDate == null
                  ? '选择日期'
                    : '日期: ${_selectedDate.toString().split(' ')[0]}'),
                  // : '日期: ${_selectCheckbox(_selectedDate)}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            // 单选
            ListTile(
              title: const Text('单选1'),
              leading: Radio<String>(
                value: '单选1',
                groupValue: _selectedRadio,
                onChanged: (String? value) {
                  setState(() {
                    _selectedRadio = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('单选2'),
              leading: Radio<String>(
                value: '单选2',
                groupValue: _selectedRadio,
                onChanged: (String? value) {
                  setState(() {
                    _selectedRadio = value;
                  });
                },
              ),
            ),
            // 多选
            CheckboxListTile(
              title: const Text('多选1'),
              value: _selectedCheckboxes.contains('多选1'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _selectedCheckboxes.add('多选1');
                  } else {
                    _selectedCheckboxes.remove('多选1');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Text('多选2'),
              value: _selectedCheckboxes.contains('多选2'),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _selectedCheckboxes.add('多选2');
                  } else {
                    _selectedCheckboxes.remove('多选2');
                  }
                });
              },
            ),
            // 文本输入
            TextFormField(
              controller: _textController,
              decoration: InputDecoration(labelText: '输入文本'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入一些文本';
                }
                return null;
              },
            ),
            // 开关
            SwitchListTile(
              title: const Text('开关'),
              value: _switchValue,
              onChanged: (bool value) {
                setState(() {
                  _switchValue = value;
                });
              },
            ),
            // 提交按钮
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('表单已提交')),
                  );
                }
              },
              child: Text('提交'),
            ),
          ],
        ),
      ),
    );
  }
}
