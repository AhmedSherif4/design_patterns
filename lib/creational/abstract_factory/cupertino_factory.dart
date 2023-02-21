//? ابنه عباس
import 'package:flutter/cupertino.dart';

import 'base_factory.dart';

class CupertinoWidgetsFactory implements WidgetsFactory {
  @override
  String getTitle() {
    return 'iOS widgets';
  }

  @override
  ActivityIndicator createActivityIndicator() {
    return IosActivityIndicator();
  }

  @override
  ISlider createSlider() {
    return IosSlider();
  }

  @override
  ISwitch createSwitch() {
    return IosSwitch();
  }
}

//? ابن عباس
class IosActivityIndicator implements ActivityIndicator {
  @override
  Widget render() {
    return const CupertinoActivityIndicator();
  }
}

//? ابن عباس
class IosSlider implements ISlider {
  @override
  Widget render(double value, ValueSetter<double> onChanged) {
    return CupertinoSlider(
      min: 0.0,
      max: 100.0,
      value: value,
      onChanged: onChanged,
    );
  }
}

//? ابن عباس
class IosSwitch implements ISwitch {
  @override
  Widget render(bool value, ValueSetter<bool> onChanged) {
    return CupertinoSwitch(
      value: value,
      onChanged: onChanged,
    );
  }
}

class IosButton implements IButton {
  @override
  Widget render(Function()? onPressed, String text) {
    return CupertinoButton(onPressed: onPressed, child: Text(text));
  }
}
