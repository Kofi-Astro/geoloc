import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mp;

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  // final LatLng initialLocation = LatLng(5.56936, -0.17509);
  final LatLng initialLocation = LatLng(5.569659073468826, -0.1744371670533428);
  bool _selectedArea = true;
  LatLng? finalPosition = LatLng(5.569659073468826, -0.1744371670533428);

  List<LatLng> polyPoints = [
    LatLng(5.569296015089658, -0.1751130836676392),
    LatLng(5.568708714295462, -0.17467320142658915),
    LatLng(5.568730070698261, -0.17423331918553914),
    LatLng(5.568879565496126, -0.17425477685583424),
    LatLng(5.56975517711987, -0.17310679149504518),
    LatLng(5.5702143387912635, -0.17504871065675381),
  ];

  void updateLocation(LatLng pointLagLgn) async {
    List<mp.LatLng> convertedPolygonPoints = polyPoints
        .map((point) => mp.LatLng(point.latitude, point.longitude))
        .toList();
    setState(() {
      _selectedArea = mp.PolygonUtil.containsLocation(
          mp.LatLng(
            pointLagLgn.latitude,
            pointLagLgn.longitude,
          ),
          convertedPolygonPoints,
          false);
    });
  }

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
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                child: Text(
              _selectedArea ? 'At work' : 'Outside work',
              style: TextStyle(fontSize: 35),
            ))),
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
              SizedBox(
                width: 60,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: const Image(
                    fit: BoxFit.contain,
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
        ));
  }

  Widget googleMap(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.73,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: initialLocation, zoom: 19),
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
          markers: {
            Marker(
                markerId: MarkerId('marker'),
                position: finalPosition!,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
                draggable: true,
                // consumeTapEvents: true,
                onDragEnd: (updatedValue) {
                  finalPosition = updatedValue;
                  updateLocation(updatedValue);
                })
          },
          // circles: {
          //   Circle(
          //       circleId: CircleId('circle'),
          //       center: initialLocation,
          //       radius: 25,
          //       // consumeTapEvents: true,
          //       strokeWidth: 2,
          //       fillColor: Colors.lightBlue.withOpacity(0.5))
          // },
          polygons: {
            Polygon(
                polygonId: PolygonId('1'),
                fillColor: Colors.blue.withOpacity(0.5),
                strokeWidth: 2,
                points: polyPoints)
          },
        ));
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long), zoom: 19, tilt: 10.0, bearing: 100.0)));
  }
}
