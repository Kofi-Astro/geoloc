import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.accessibleIcon),
          onPressed: () {},
        ),
        title: const Text('Offices'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
            ),
          ),
        ],
      ),
      body: Stack(children: [
        googleMap(context),
        buildContainer(),
      ]),
    );
  }

  Widget buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: boxes(5.60159, -0.22558, "Office 7"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: boxes(5.58476, -0.16780, "Office 5"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: boxes(5.56150, -0.19866, "Office 1"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: boxes(5.55453, -0.19303, "Office 3"),
            ),
          ],
        ),
      ),
    );
  }

  Widget boxes(double lat, double long, String officeName) {
    return GestureDetector(
        onTap: () {
          _gotoLocation(lat, long);
        },
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular((24.0)),
          shadowColor: Colors.purple,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // SizedBox(
              //   width: 60,
              //   height: 80,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(24.0),
              //     child: const Image(
              //       fit: BoxFit.contain,
              //       image: AssetImage(
              //         'assets/images/office.png',
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(officeName),
              ),
            ],
          ),
        ));
  }

  Widget googleMap(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition:
              const CameraPosition(target: LatLng(5.56936, -0.17509), zoom: 20),
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
        ));
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long), zoom: 20, tilt: 70.0, bearing: 50.0)));
  }
}

// Marker office1Marker = Marker(
//   markerId: MarkerId('office1'),
//   position: LatLng(30.744600, 76.652496),
//   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
// );
