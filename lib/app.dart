import 'package:flutter/material.dart';
import './pages/auth.dart';
import './pages/dashboard.dart';
import './services/auth.dart';

class App extends StatelessWidget {
  App({super.key});
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
