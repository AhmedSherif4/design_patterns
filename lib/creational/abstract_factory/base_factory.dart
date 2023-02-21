
import 'package:flutter/widgets.dart';

//? كلمة السر هي الأب مع الأب والأبن مع الأبن


//! شيخ العرب

abstract class WidgetsFactory {
  //* هنا شيخ العربي بياخد النتيجة من المدرسين مش من أحفاده ولا من عياله
  String getTitle();
  //* abstracts بيتعاملوا مع بعض
  ActivityIndicator createActivityIndicator();
  ISlider createSlider();
  ISwitch createSwitch();
}

//! مدرس العربي
abstract class ActivityIndicator {
  Widget render();
}

//! مدرس الانجليزي
abstract class ISlider {
  Widget render(double value, ValueSetter<double> onChanged);
}

//! مدرس الرياضة
abstract class ISwitch {
  Widget render(bool value, ValueSetter<bool> onChanged);
}

abstract class IButton{
  Widget render(Function()? onPressed, String text);
}