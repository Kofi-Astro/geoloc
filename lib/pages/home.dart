import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoloc/models/office.dart';
import 'package:geoloc/pages/dashboard.dart';
import 'package:geoloc/services/geofenc.dart';

import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late PermissionStatus result;
  var geoFenceActive = false;
  Office? allotedOffice;

  String? error;

  List<Office> office = [
    Office(
      key: '1',
      name: 'Office 1',
      latitude: 5.56150,
      longitude: -0.19866,
      radius: 5.0,
    ),
    Office(
      key: '2',
      name: 'Office 2',
      latitude: 5.55453,
      longitude: -0.19303,
      radius: 5.0,
    ),
    Office(
      key: '3',
      name: 'Office 3',
      latitude: 5.58476,
      longitude: -0.16780,
      radius: 5.0,
    ),
    Office(
      key: '4',
      name: 'Office 4',
      latitude: 5.60159,
      longitude: -0.22558,
      radius: 5.0,
    ),
  ];

  @override
  void initState() {
    _initializeGeoFence(context);
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100), value: 1);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  Future<void> _initializeGeoFence(BuildContext context) async {
    try {
      result = await Permission.location.request();
      switch (result) {
        case PermissionStatus.granted:
          // print()
          // geoFenceActive = true;
          for (int i = 0; i < office.length; i++) {
            // GeoFencing.of(context).service.startGeofencing(office[i]);
            setState(() {
              geoFenceActive = true;
              allotedOffice = office[i];
            });
          }
          break;
        case PermissionStatus.denied:
          print('DENIED');
          break;
        case PermissionStatus.permanentlyDenied:
          //do something
          break;
        case PermissionStatus.restricted:
          //do something
          break;
        default:
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
    }
  }

  void showDialogNotification(BuildContext context, String text) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blue, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.blue)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Okay',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 65),
          child: Text(
            'Dashboard',
            style: TextStyle(fontSize: 25),
          ),
        ),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: controller.view,
          ),
        ),
      ),
      body: geoFenceActive == false
          ? Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(70, 174, 197, 73),
                    Color.fromARGB(117, 86, 180, 141)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topRight,
                ),
              ),
              child: const Column(children: <Widget>[
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(103, 133, 145, 209)),
                ),
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                    "Please Wait..\nwhile we are setting up things",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                )
              ]))
          : DashBoardPage(controller: controller),
    );
  }
}
