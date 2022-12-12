import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';

import '../api.dart';
import '../models/model.dart';

class ModelTab extends StatefulWidget {
  const ModelTab({super.key});

  @override
  State<ModelTab> createState() => _ModelTabState();
}

class _ModelTabState extends State<ModelTab> {
  final _api = Api.instance;
  var _models = <Model>[];

  @override
  void initState() {
    super.initState();
    _api.getModels().then((models) {
      setState(() {
        _models = models;
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
          largeTitle: Text('Models')
        ),
        // This widget fills the remaining space in the viewport.
        // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            var models = await _api.getModels();
            setState(() {
              _models = models;
            });
          },
        ),
        _models.isNotEmpty
            ? SliverSafeArea(
                top: false,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final model = _models[index];
                      return CupertinoListTile(
                        title: Text(model.name),
                      );
                    },
                    childCount: _models.length,
                  ),
                ),
              )
            : const SliverFillRemaining(
                child: Center(
                  child: Text("No models found"),
                ),
              )
      ],
    );
  }
}
