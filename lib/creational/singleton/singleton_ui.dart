import 'package:design_patterns/creational/singleton/singleton.dart';
import 'package:flutter/material.dart';

class SingletonExample extends StatefulWidget {
  const SingletonExample({super.key});

  @override
  State<StatefulWidget> createState() => _SingletonExampleState();
}

class _SingletonExampleState extends State<SingletonExample> {
  final List<ExampleStateBase> stateList = [
    ExampleState(),
    ExampleStateByDefinition.getState(),
    ExampleStateWithoutSingleton()
  ];

  void _setTextValues([String text = 'Singleton']) {
    for (var state in stateList) {
      state.setStateText(text);
    }
    setState(() {});
  }

  void _reset() {
    for (var state in stateList) {
      state.reset();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              for (var state in stateList)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    state.currentText,
                  ),
                ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _setTextValues,
                child: const Text("Change states\' text to 'Singleton'"),
              ),
              TextButton(
                onPressed: _reset,
                child: const Text("Reset"),
              ),
              const SizedBox(height: 20),
              const Text(
                'Note: change states\' text and navigate the application (e.g. go to the tab "description" or main menu, then go back to this example) to see how the Singleton state behaves!',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
