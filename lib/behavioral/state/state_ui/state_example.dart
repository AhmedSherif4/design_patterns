import 'package:flutter/material.dart';

import '../../../structural/bridge/bridge/bridge_example.dart';
import '../state.dart';


class StateExample extends StatefulWidget {
  const StateExample({super.key});

  @override
  State<StatefulWidget> createState() => _StateExampleState();
}

class _StateExampleState extends State<StateExample> {
  final StateContext _stateContext = StateContext();

  Future<void> _changeState() async {
    await _stateContext.nextState();
  }

  @override
  void dispose() {
    _stateContext.dispose();
    super.dispose();
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
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeState,
              text: 'Load names',
            ),
            const SizedBox(height: 12),
            StreamBuilder<IState>(
              initialData: NoResultsState(),
              stream: _stateContext.outState,
              builder: (context, snapshot) => snapshot.data!.render(),
            ),
          ],
        ),
      ),
    );
  }
}
