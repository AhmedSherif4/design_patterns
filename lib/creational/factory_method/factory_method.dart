import 'package:flutter/material.dart';

import 'custom_dialog.dart';
import 'custom_dialog_base.dart';

class FactoryMethodExample extends StatefulWidget {
  const FactoryMethodExample({super.key});

  @override
  State<StatefulWidget> createState() => _FactoryMethodExampleState();
}

class _FactoryMethodExampleState extends State<FactoryMethodExample> {
  final List<CustomDialog> customDialogList = [
    AndroidAlertDialog(),
    IosAlertDialog(),
  ];

  int _selectedDialogIndex = 0;

  Future _showCustomDialog(BuildContext context) async {
    CustomDialog selectedDialog = customDialogList[_selectedDialogIndex];

    await selectedDialog.show(context);
  }

  void _setSelectedDialogIndex(int index) {
    setState(() {
      _selectedDialogIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
               dialogSelection(
                customDialogList: customDialogList,
                selectedIndex: _selectedDialogIndex,
                onChanged: _setSelectedDialogIndex,
              ), 
              const SizedBox(height: 20),
              TextButton(
                child: const Text('Show Dialog'),
                onPressed: () => _showCustomDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dialogSelection(
      {required List<CustomDialog> customDialogList,
      required int selectedIndex,
      required void Function(int index) onChanged}) {
        return Column(
          children: [
            Row(
              children: [
                Radio(
                  
                    value: customDialogList[selectedIndex],
                    groupValue: selectedIndex,
                    onChanged: (value) {
                      print('ANDROID: ${value.runtimeType}');
                      onChanged(0);
                    }),
                Text(customDialogList[0].getTitle()),
              ],
            ),
           Row(
              children: [
                Radio(
                    value: customDialogList[selectedIndex],
                    groupValue: selectedIndex,
                    onChanged: (value) {
                      print('IOS: ${value.runtimeType}');
                      onChanged(1);
                    }),
                Text(customDialogList[1].getTitle()),
              ],
            ),
          ],
        );
  }
}
