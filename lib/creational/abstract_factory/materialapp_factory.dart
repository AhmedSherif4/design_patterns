//? ابنه محمد
import 'package:flutter/material.dart';

import 'base_factory.dart';

class MaterialWidgetsFactory implements WidgetsFactory {
  @override
  String getTitle() {
    return 'Android widgets';
  }

  //* هنا كل واحد بياخد النتيجة من عياله
  @override
  ActivityIndicator createActivityIndicator() {
    return AndroidActivityIndicator();
  }

  @override
  ISlider createSlider() {
    return AndroidSlider();
  }

  @override
  ISwitch createSwitch() {
    return AndroidSwitch();
  }
}

//? ابن محمد
class AndroidActivityIndicator implements ActivityIndicator {
  @override
  Widget render() {
    return CircularProgressIndicator(
      backgroundColor: const Color(0xFFECECEC),
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.black.withOpacity(0.65),
      ),
    );
  }
}

//? ابن محمد
class AndroidSlider implements ISlider {
  @override
  Widget render(double value, ValueSetter<double> onChanged) {
    return Slider(
      activeColor: Colors.black,
      inactiveColor: Colors.grey,
      min: 0.0,
      max: 100.0,
      value: value,
      onChanged: onChanged,
    );
  }
}

//? ابن محمد
class AndroidSwitch implements ISwitch {
  @override
  Widget render(bool value, ValueSetter<bool> onChanged) {
    return Switch(
      activeColor: Colors.black,
      value: value,
      onChanged: onChanged,
    );
  }
}

class AndroidButton implements IButton{
  @override
  Widget render(Function()? onPressed, String text) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }

}