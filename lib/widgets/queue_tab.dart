import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrra_flutter/models/queue.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';

import '../api.dart';
import 'task_form_page.dart';

class QueueTab extends StatefulWidget {
  const QueueTab({super.key});

  @override
  State<QueueTab> createState() => _QueueTabState();
}

class _QueueTabState extends State<QueueTab> {
  final _api = Api.instance;
  var _queue = <QueueItem>[];

  @override
  void initState() {
    super.initState();
    _api.getQueue().then((queue) {
      setState(() {
        _queue = queue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // A list of sliver widgets.
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          leading: Icon(CupertinoIcons.tray_full_fill),
          // This title is visible in both collapsed and expanded states.
          // When the "middle" parameter is omitted, the widget provided
          // in the "largeTitle" parameter is used instead in the collapsed state.
          largeTitle: Text('Queue'),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(CupertinoIcons.add),
            onPressed: () {
              _addTask().then((value) {
                if (value != null) {
                  setState(() {
                    _queue.add(value);
                  });
                }
              });
            },
          ),
        ),
        // This widget fills the remaining space in the viewport.
        // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            var queue = await _api.getQueue();
            setState(() {
              _queue = queue;
            });
          },
        ),
        _queue.isNotEmpty
            ? SliverSafeArea(
                top: false,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final item = _queue[index];
                      return CupertinoListTile(
                        trailing: {
                          QueueItemStatus.completed: const Icon(
                              CupertinoIcons.check_mark_circled,
                              color: CupertinoColors.activeGreen),
                          QueueItemStatus.failed: const Icon(
                              CupertinoIcons.xmark_circle,
                              color: CupertinoColors.destructiveRed),
                          QueueItemStatus.inProgress: const Icon(
                              CupertinoIcons.clock,
                              color: CupertinoColors.activeBlue),
                          QueueItemStatus.pending: const Icon(
                              CupertinoIcons.tray_full,
                              color: CupertinoColors.systemGrey),
                        }[item.status]!,
                        title: Text(item.name,
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Text(item.created.toString(),
                            style: Theme.of(context).textTheme.caption),
                        dense: true,
                      );
                    },
                    childCount: _queue.length,
                  ),
                ),
              )
            : const SliverFillRemaining(
                child: Center(
                  child: Text("No tasks in queue"),
                ),
              )
      ],
    );
  }

  Future<QueueItem?> _addTask() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
      withData: true,
    );
    if (result == null) return null;
    var file = result.files.first;
    var item = await Navigator.of(context).push<QueueItem>(
      CupertinoPageRoute(
        title: "New Task",
        builder: (context) => TaskFormPage(
          file: file,
        ),
      ),
    );
    return item;
  }
}
