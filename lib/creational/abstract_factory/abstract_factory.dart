import 'package:flutter/material.dart';

import 'base_factory.dart';
import 'cupertino_factory.dart';
import 'materialapp_factory.dart';

class AbstractFactoryExample extends StatefulWidget {
  const AbstractFactoryExample({super.key});

  @override
  State<StatefulWidget> createState() => _AbstractFactoryExampleState();
}

class _AbstractFactoryExampleState extends State<AbstractFactoryExample> {
  final List<WidgetsFactory> widgetsFactoryList = [
    MaterialWidgetsFactory(),
    CupertinoWidgetsFactory(),
  ];

  int _selectedFactoryIndex = 0;

  late ActivityIndicator _activityIndicator;

  late ISlider _slider;
  double _sliderValue = 50.0;
  String get _sliderValueString => _sliderValue.toStringAsFixed(0);

  late ISwitch _switch;
  bool _switchValue = false;
  String get _switchValueString => _switchValue ? 'ON' : 'OFF';

  @override
  void initState() {
    super.initState();
    _createWidgets();
  }

  void _createWidgets() {
    _activityIndicator =
        widgetsFactoryList[_selectedFactoryIndex].createActivityIndicator();
    _slider = widgetsFactoryList[_selectedFactoryIndex].createSlider();
    _switch = widgetsFactoryList[_selectedFactoryIndex].createSwitch();
  }

  void _setSelectedFactoryIndex(int index) {
    setState(() {
      _selectedFactoryIndex = index;
      _createWidgets();
    });
  }

  void _setSliderValue(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  void _setSwitchValue(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    //! the import:
    final WidgetsFactory factoryWidgets =
        Theme.of(context).platform == TargetPlatform.android
            ? MaterialWidgetsFactory()
            : CupertinoWidgetsFactory();
    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              factorySelection(
                widgetsFactoryList: widgetsFactoryList,
                selectedIndex: _selectedFactoryIndex,
                onChanged: _setSelectedFactoryIndex,
              ),
              const SizedBox(height: 20),
              Text(
                'Widgets showcase',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Text(
                'Process indicator',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              //! the import:
              factoryWidgets.createActivityIndicator().render(),
              _activityIndicator.render(),
              const SizedBox(height: 20),
              Text(
                'Slider ($_sliderValueString%)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              _slider.render(_sliderValue, _setSliderValue),
              const SizedBox(height: 20),
              Text(
                'Switch ($_switchValueString)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              _switch.render(_switchValue, _setSwitchValue),
            ],
          ),
        ),
      ),
    );
  }

  factorySelection(
      {required List<WidgetsFactory> widgetsFactoryList,
      required int selectedIndex,
      required void Function(int index) onChanged}) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () => onChanged(0), icon: const Icon(Icons.android)),
            Text(widgetsFactoryList[0].getTitle()),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () => onChanged(1), icon: const Icon(Icons.apple)),
            Text(widgetsFactoryList[1].getTitle()),
          ],
        ),
      ],
    );
  }
}
