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
        // buildContainer(),
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
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: boxes(30.744600, 76.652496, "Office 7"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: boxes(30.744600, 76.652496, "Office 5"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: boxes(30.744600, 76.652496, "Office 1"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: boxes(30.744600, 76.652496, "Office 3"),
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
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular((24.0)),
            shadowColor: Colors.purple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: const Image(
                      fit: BoxFit.scaleDown,
                      image: AssetImage(
                        'assets/images/office.png',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(officeName),
                ),
              ],
            ),
          ),
        ));
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Widget googleMap(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.5,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          // CameraPosition(target: LatLng(20.5937, 78.9629), zoom: 12),
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
        ));
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long), zoom: 15, tilt: 50.0, bearing: 45.0)));
  }
}

// Marker office1Marker = Marker(
//   markerId: MarkerId('office1'),
//   position: LatLng(30.744600, 76.652496),
//   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
// );
