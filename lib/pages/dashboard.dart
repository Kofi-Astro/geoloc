import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashBoardPage extends StatefulWidget {
  final AnimationController? controller;
  const DashBoardPage({super.key, this.controller});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  static const header_height = 100.0;
  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    final frontPanelHeight = -header_height;

    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
              0.0,
              backPanelHeight,
              0.0,
              frontPanelHeight,
            ),
            end: RelativeRect.fromLTRB(0, 0.0, 0.0, 0.0))
        .animate(
            CurvedAnimation(parent: widget.controller!, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Container(
      child: Stack(children: [
        Container(
          color: Colors.deepPurple,
          child: Center(
              child: Text(
            'Navigation Panel',
            style: TextStyle(fontSize: 24, color: Colors.white),
          )),
        ),
        PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(
                  16,
                ),
              ),
              child: Column(children: [
                Expanded(
                  child: Center(
                    child: DashboardMainPanel(),
                  ),
                )
              ]),
            ))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}

class DashboardMainPanel extends StatelessWidget {
  List<Widget> _listWidget() {
    List<Widget> widgets = [];
    tileData.forEach((tile) {
      widgets.add(buildTile(tile[0], tile[1], tile[2], tile[3]));
    });
    return widgets;
  }

  List<StaggeredGridTile> _staggeredTiles(int index) {
    List<StaggeredGridTile> widgets = [];
    tileData.forEach((tile) {
      widgets.add(StaggeredGridTile.extent(
          crossAxisCellCount: 1, mainAxisExtent: 210, child: tile[index]));
    });
    return widgets;
  }

  Widget buildTile(
      IconData icon, String title, String subtitle, Function() onTap) {
    return Material(
      elevation: 10,
      shadowColor: Colors.deepPurpleAccent,
      borderRadius: BorderRadius.circular(12),
      color: Colors.deepPurpleAccent,
      child: InkWell(
        onTap: onTap != null
            ? () => onTap()
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

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: const Color(0xffffffff),
    //   appBar: PreferredSize(
    //     preferredSize: const Size.fromHeight(90.0),
    //     child: AppBar(
    //       leading: const Padding(
    //         padding: EdgeInsets.all(21),
    //         child: Icon(
    //           Icons.equalizer,
    //           color: Colors.deepPurpleAccent,
    //           size: 50,
    //         ),
    //       ),
    //       title: const Padding(
    //         padding: EdgeInsets.only(top: 35, left: 8),
    //         child: Text(
    //           'DASHBOARD',
    //           style: TextStyle(
    //               fontSize: 20,
    //               color: Colors.blue,
    //               fontWeight: FontWeight.w900),
    //         ),
    //       ),
    //       flexibleSpace: Container(
    //         decoration: const BoxDecoration(
    //           gradient: LinearGradient(
    //               colors: [
    //                 Color(0xffffffff),
    //                 Color(0xffffffff),
    //               ],
    //               begin: FractionalOffset(
    //                 0.0,
    //                 0.0,
    //               ),
    //               end: FractionalOffset(1.0, 0.0),
    //               stops: [0.0, 1.0],
    //               tileMode: TileMode.clamp),
    //         ),
    //       ),
    //       elevation: 10,
    //     ),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(8),
    //     child: StaggeredGrid.count(
    //       crossAxisCount: 2,
    //       crossAxisSpacing: 12,
    //       mainAxisSpacing: 12,
    //       children: _listWidget(),
    //     ),
    //   ),
    // );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: _listWidget(),
      ),
    );
  }

  List<List> tileData = [
    [
      Icons.record_voice_over,
      'Attendance Recorder',
      'Mark In and Out Time',
      () {}
    ],
    [
      Icons.record_voice_over,
      'Attendace Summary',
      'Check previous Records',
      () {}
    ],
    [
      Icons.record_voice_over,
      'Attendance Recorder',
      'Mark In and Out Time',
      () {}
    ],
    [
      Icons.record_voice_over,
      'Attendace Summary',
      'Check previous Records',
      () {}
    ],
  ];
}
