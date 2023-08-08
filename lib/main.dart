import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoloc/pages/home.dart';

import './pages/auth.dart';
import './pages/dashboard.dart';
import './services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geoloc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthPage(),
      // home: DashBoardPage(),
      // home: HomeScreen(),
    );
  }
}
