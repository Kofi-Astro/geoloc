import 'package:flutter/material.dart';
import 'package:geoloc/pages/home.dart';

import '../pages/attendance_recorder.dart';

void attendanceSummaryCallback(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomeScreen()));
}

void attendanceRecorderCallback(BuildContext context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AttendancePage()));
}

List<List> infoAboutTiles = [
  [
    Icons.pin_drop,
    "Attendance Recorder",
    'Mark In and Out Time',
    attendanceRecorderCallback,
  ],
  [
    Icons.subject,
    'Attendance Summary',
    'Check Previous Record',
    attendanceSummaryCallback,
  ],
  [
    Icons.pin_drop,
    "Attendance Recorder",
    'Mark In and Out Time',
    attendanceRecorderCallback,
  ],
  [
    Icons.subject,
    'Attendance Summary',
    'Check Previous Record',
    attendanceSummaryCallback,
  ],
];








  // List<List> tileData = [
  //   [
  //     Icons.record_voice_over,
  //     'Attendance Recorder',
  //     'Mark In and Out Time',
  //     () {
  //       // Navigator.of(context).push()
  //     }
  //   ],
  //   [
  //     Icons.record_voice_over,
  //     'Attendace Summary',
  //     'Check previous Records',
  //     () {}
  //   ],
  //   [
  //     Icons.record_voice_over,
  //     'Attendance Recorder',
  //     'Mark In and Out Time',
  //     () {}
  //   ],
  //   [
  //     Icons.record_voice_over,
  //     'Attendace Summary',
  //     'Check previous Records',
  //     () {}
  //   ],
  // ];