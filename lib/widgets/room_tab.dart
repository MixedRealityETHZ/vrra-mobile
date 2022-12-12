import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';

import '../api.dart';
import '../models/room.dart';

class RoomTab extends StatefulWidget {
  const RoomTab({super.key});

  @override
  State<RoomTab> createState() => _RoomTabState();
}

class _RoomTabState extends State<RoomTab> {
  final _api = Api.instance;
  var _rooms = <Room>[];

  @override
  void initState() {
    super.initState();
    _api.getRooms().then((rooms) {
      setState(() {
        _rooms = rooms;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // A list of sliver widgets.
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          leading: Icon(CupertinoIcons.house_fill),
          // This title is visible in both collapsed and expanded states.
          // When the "middle" parameter is omitted, the widget provided
          // in the "largeTitle" parameter is used instead in the collapsed state.
          largeTitle: Text('Rooms')
        ),
        // This widget fills the remaining space in the viewport.
        // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            var rooms = await _api.getRooms();
            setState(() {
              _rooms = rooms;
            });
          },
        ),
        _rooms.isNotEmpty
            ? SliverSafeArea(
                top: false,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final room = _rooms[index];
                      return CupertinoListTile(
                        title: Text(room.name),
                      );
                    },
                    childCount: _rooms.length,
                  ),
                ),
              )
            : const SliverFillRemaining(
                child: Center(
                  child: Text("No rooms found"),
                ),
              )
      ],
    );
  }
}
