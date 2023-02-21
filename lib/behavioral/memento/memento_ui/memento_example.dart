import 'package:flutter/material.dart';

import '../../../structural/bridge/bridge/bridge_example.dart';
import '../memento.dart';
import 'shape_container.dart';

class MementoExample extends StatefulWidget {
  const MementoExample();

  @override
  State<StatefulWidget> createState() => _MementoExampleState();
}

class _MementoExampleState extends State<MementoExample> {

  final CommandHistory _commandHistory = CommandHistory();
  
  final Originator _originator = Originator();

  void _randomiseProperties() {
    final command = RandomisePropertiesCommand(_originator);
    _executeCommand(command);
  }

  void _executeCommand(ICommand command) {
    setState(() {
      command.execute();
      _commandHistory.add(command);
    });
  }

  void _undo() {
    setState(() {
      _commandHistory.undo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          children: <Widget>[
            ShapeContainer(
              shape: _originator.state,
            ),
            const SizedBox(height: 12),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _randomiseProperties,
              text: 'Randomise properties',
            ),
            const Divider(),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _commandHistory.isEmpty ? null : _undo,
              text: 'Undo',
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
