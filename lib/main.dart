import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoloc/pages/home.dart';
import 'package:geoloc/services/geofenc.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // runApp(MyApp());

  runApp(GeoFencing(child: App(), service: GeoFencingService()));
}
