import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import '../api.dart';
import '../models/queue.dart';

class TaskFormPage extends StatefulWidget {
  PlatformFile file;

  TaskFormPage({Key? key, required this.file}) : super(key: key);

  @override
  _TaskFormPageState createState() => _TaskFormPageState();
}

class _TaskFormPageState extends State<TaskFormPage> {
  final _task = PushQueueBody("", 0, "");
  final _api = Api.instance;
  final _formKey = GlobalKey<FormState>();
  var _busy = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(_busy ? 'Submitting' : 'New Task'),
        trailing: _busy
            ? const CupertinoActivityIndicator()
            : CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('Save'),
                onPressed: _save,
              ),
      ),
      child: SafeArea(
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: CupertinoFormSection.insetGrouped(
                header: const Text('Task'),
                children: [
                  CupertinoTextFormFieldRow(
                    placeholder: 'Name',
                    autofocus: true,
                    enabled: !_busy,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Name is required'
                        : null,
                    onSaved: (value) => _task.name = value!,
                  ),
                  CupertinoTextFormFieldRow(
                    placeholder: 'Path',
                    initialValue: "textured_output.obj",
                    enabled: !_busy,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Path is required'
                        : null,
                    onSaved: (value) => _task.path = value!,
                  ),
                ],
              ))),
    );
  }

  Future<QueueItem> _pushQueue() async {
    final file = widget.file;
    var asset = await _api.uploadAsset(file.name, file.bytes!);
    _task.assetId = asset.id;
    return await _api.pushQueue(_task);
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _busy = true;
      });
      _pushQueue().then((item) {
        setState(() {
          _busy = false;
        });
        Navigator.of(context).pop(item);
      });
    }
  }
}
