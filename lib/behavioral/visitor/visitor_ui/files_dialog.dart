import 'package:flutter/material.dart';

import '../../../structural/bridge/bridge/bridge_example.dart';


class FilesDialog extends StatelessWidget {
  final String filesText;

  const FilesDialog({
    required this.filesText,
  });

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Files'),
      content: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(filesText),
          ),
        ),
      ),
      actions: <Widget>[
        PlatformButton(
          materialColor: Colors.black,
          materialTextColor: Colors.white,
          onPressed: () => closeDialog(context),
          text: 'Close',
        ),
      ],
    );
  }
}
