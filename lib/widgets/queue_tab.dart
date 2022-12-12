import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:vrra_flutter/models/queue.dart';

import '../api.dart';
import 'task_form_page.dart';

class QueueTab extends StatefulWidget {
  const QueueTab({super.key});

  @override
  State<QueueTab> createState() => _QueueTabState();
}

class _QueueTabState extends State<QueueTab> {
  final _api = Api.instance;

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
              _addTask();
            },
          ),
        ),
        // This widget fills the remaining space in the viewport.
        // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
        CupertinoSliverRefreshControl(
          onRefresh: () async {
            await Future<void>.delayed(
              const Duration(milliseconds: 1000),
            );
            setState(() {});
          },
        ),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (BuildContext context, int index) => items[index],
        //     childCount: items.length,
        //   ),
        // ),
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
