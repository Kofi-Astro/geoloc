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

Widget buildTile(
    IconData icon, String title, String subtitle, BuildContext context,
    [Function(BuildContext)? onTap]) {
  return Material(
    elevation: 10,
    shadowColor: Colors.deepPurpleAccent,
    borderRadius: BorderRadius.circular(12),
    color: Colors.deepPurpleAccent,
    child: InkWell(
      onTap: onTap != null
          ? () {
              onTap(context);
            }
          : () {
              print('Not set yet');
            },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              color: Colors.white70,
              shape: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  icon,
                  color: Colors.deepPurple,
                  size: 30,
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}



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