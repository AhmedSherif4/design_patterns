// شغال بإنه بيعمل انستنس مرة واحدة بس مهما عدد الاوبجيكتس زاد

abstract class ExampleStateBase {
  late String _initialText;
  late String _stateText;
  String get currentText => _stateText;

  void setStateText(String text) {
    _stateText = text;
  }

  void reset() {
    _stateText = _initialText;
  }
}

class ExampleStateByDefinition extends ExampleStateBase {
  //! قيمة قديمة
  static  ExampleStateByDefinition? _instance;
  //? قيمة جديدة
  ExampleStateByDefinition._internal() {
    _initialText =
        "A new 'ExampleStateByDefinition' instance has been created.";
    _stateText = _initialText;
    print(_stateText);
  }
  //* لو فيه قديم جيبه، لو مافيش قديم جيب الجديد
  static ExampleStateByDefinition getState() {
    _instance = _instance?? ExampleStateByDefinition._internal();

    return _instance!;
  }
}

class ExampleState extends ExampleStateBase {
  //! قيمة قديمة، وإدتلها قيمة مبدأية وهي الجديدة
  static final ExampleState _instance = ExampleState._internal();
  //* رجعلي القيمة القديمة اللي لو مش موجود قديم انت معاك قيمة مبدأية
  factory ExampleState() {
    return _instance;
  }
  //? القيمة المبدأية
  ExampleState._internal() {
    _initialText = "A new 'ExampleState' instance has been created.";
    _stateText = _initialText;
    print(_stateText);
  }
}

class ExampleStateWithoutSingleton extends ExampleStateBase {
  // الشكل العادي من غير أفشخنات
  ExampleStateWithoutSingleton() {
    _initialText =
        "A new 'ExampleStateWithoutSingleton' instance has been created.";
    _stateText = _initialText;
    print(_stateText);
  }
}
