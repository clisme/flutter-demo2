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
   TimeOfDay? _selectedTime;
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
      });
    }
  }

   void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Widget _buildDatePicker() {
    return ListTile(
      title: Text(_selectedDate == null
          ? '选择日期'
          : '日期: ${_selectedDate!.toString().split(' ')[0]}'),
      trailing: Icon(Icons.calendar_today),
      onTap: () => _selectDate(context),
    );
  }

   Widget _buildTimePicker() {
    return ListTile(
      title: Text(_selectedTime == null
          ? '选择时间'
          : '时间: ${_selectedTime!.format(context)}'),
      trailing: Icon(Icons.access_time),
      onTap: () => _selectTime(context),
    );
  }



  Widget _buildRadio(String title, String value) {
    return ListTile(
      title: Text('* $title'),
      leading: Radio<String>(
        value: value,
        groupValue: _selectedRadio,
        onChanged: (String? value) {
          setState(() {
            _selectedRadio = value;
          });
        },
      ),
    );
  }

  Widget _buildCheckbox(String title) {
    return CheckboxListTile(
      title: Text(title),
      value: _selectedCheckboxes.contains(title),
      onChanged: (bool? value) {
        setState(() {
          if (value == true) {
            _selectedCheckboxes.add(title);
          } else {
            _selectedCheckboxes.remove(title);
          }
        });
      },
    );
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: _textController,
      decoration: InputDecoration(labelText: '输入文本'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '请输入一些文本';
        }
        return null;
      },
    );
  }

  Widget _buildSwitch() {
    return SwitchListTile(
      title: Text('开关'),
      value: _switchValue,
      onChanged: (bool value) {
        setState(() {
          _switchValue = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
         _buildDatePicker(),
            _buildTimePicker(),
            _buildRadio('单选1', '单选1'),
            _buildRadio('单选2', '单选2'),
            _buildCheckbox('多选1'),
            _buildCheckbox('多选2'),
            _buildTextField(),
            _buildSwitch(),
            SizedBox(height: 20),
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