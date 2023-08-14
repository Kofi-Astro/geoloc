import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// import './attendance_recorder.dart';
import '../constants/dashboard_tile_info.dart';

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
            end: const RelativeRect.fromLTRB(0, 0.0, 0.0, 0.0))
        .animate(
            CurvedAnimation(parent: widget.controller!, curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Container(
      child: Stack(children: [
        Container(
          color: Colors.deepPurple,
          child: const Center(
              child: Text(
            'Navigation Panel',
            style: TextStyle(fontSize: 24, color: Colors.white),
          )),
        ),
        PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: Material(
              elevation: 12,
              borderRadius: const BorderRadius.only(
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
  final List tileData = infoAboutTiles;

  List<Widget> _listWidget(BuildContext context) {
    List<Widget> widgets = [];
    tileData.forEach((tile) {
      widgets.add(buildTile(tile[0], tile[1], tile[2], context, tile[3]));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(39, 59, 151, 204),
              Color.fromARGB(220, 113, 51, 228)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: _listWidget(context),
        ),
      ),
    );
  }
}
