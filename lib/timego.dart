// import 'package:flutter/material.dart';
// import 'dart:async';

// class CalendarPage extends StatefulWidget {
//   @override
//   _CalendarPageState createState() => _CalendarPageState();
// }

// class _CalendarPageState extends State<CalendarPage> {
//   DateTime? selectedDate;
//   Duration? timeLeft;
//   Timer? timer;

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         _startTimer();
//       });
//     }
//   }

//   void _startTimer() {
//     timer?.cancel();
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         timeLeft = selectedDate!.difference(DateTime.now());
//         if (timeLeft!.isNegative) {
//           timer.cancel();
//           timeLeft = null;
//         }
//       });
//     });
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String days = twoDigits(duration.inDays);
//     String hours = twoDigits(duration.inHours.remainder(24));
//     String minutes = twoDigits(duration.inMinutes.remainder(60));
//     String seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$days天 $hours小时 $minutes分钟 $seconds秒";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('日历选择与倒计时'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () => _selectDate(context),
//               child: Text('选择日期'),
//             ),
//             SizedBox(height: 20),
//             if (selectedDate != null)
//               Text(
//                 "选择的日期: ${selectedDate!.toLocal()}",
//                 style: TextStyle(fontSize: 16),
//               ),
//             if (timeLeft != null && !timeLeft!.isNegative)
//               Text(
//                 "倒计时: ${_formatDuration(timeLeft!)}",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: CalendarPage(),
//   ));
// }




import 'package:flutter/material.dart';
import 'dart:async';

class DateTimePickerPage extends StatefulWidget {
  @override
  _DateTimePickerPageState createState() => _DateTimePickerPageState();
}

class _DateTimePickerPageState extends State<DateTimePickerPage> {
  DateTime? selectedDateTime;
  Duration? timeLeft;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    // 选择日期
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // 选择时间
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // 合并日期和时间
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          selectedDateTime = combinedDateTime;
          _startTimer();
        });
      }
    }
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft = selectedDateTime!.difference(DateTime.now());
        if (timeLeft!.isNegative) {
          timer.cancel();
          timeLeft = null;
        }
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String days = twoDigits(duration.inDays);
    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$days天 $hours小时 $minutes分钟 $seconds秒";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('日期和时间选择'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDateTime(context),
              child: Text('选择日期和时间'),
            ),
            SizedBox(height: 20),
            if (selectedDateTime != null)
              Text(
                "选择的日期和时间: ${selectedDateTime!.toLocal()}",
                style: TextStyle(fontSize: 16),
              ),
            if (timeLeft != null && !timeLeft!.isNegative)
              Text(
                "倒计时: ${_formatDuration(timeLeft!)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DateTimePickerPage(),
  ));
}