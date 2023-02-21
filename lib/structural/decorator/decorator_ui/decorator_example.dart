import 'package:flutter/material.dart';

import '../pizza.dart';
import '../pizza_menu.dart';
import '../pizza_topping_data.dart';
import 'custom_pizza_selection.dart';
import 'pizza_information.dart';
import 'pizza_selection.dart';

class DecoratorExample extends StatefulWidget {
  const DecoratorExample();

  @override
  State<StatefulWidget> createState() => _DecoratorExampleState();
}

class _DecoratorExampleState extends State<DecoratorExample> {
  final PizzaMenu pizzaMenu = PizzaMenu();

  late final Map<int, PizzaToppingData> _pizzaToppingsDataMap;
  late Pizza _pizza;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pizzaToppingsDataMap = pizzaMenu.getPizzaToppingsDataMap();
    _pizza = pizzaMenu.getPizza(0, _pizzaToppingsDataMap);
  }

  void _onSelectedIndexChanged(int? index) {
    _setSelectedIndex(index!);
    _setSelectedPizza(index);
  }

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCustomPizzaChipSelected(int index, bool? selected) {
    _setChipSelected(index, selected!);
    _setSelectedPizza(_selectedIndex);
  }

  void _setChipSelected(int index, bool selected) {
    setState(() {
      _pizzaToppingsDataMap[index]!.setSelected(isSelected: selected);
    });
  }

  void _setSelectedPizza(int index) {
    setState(() {
      _pizza = pizzaMenu.getPizza(index, _pizzaToppingsDataMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Select your pizza:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              PizzaSelection(
                selectedIndex: _selectedIndex,
                onChanged: _onSelectedIndexChanged,
              ),
              if (_selectedIndex == 2)
                CustomPizzaSelection(
                  pizzaToppingsDataMap: _pizzaToppingsDataMap,
                  onSelected: _onCustomPizzaChipSelected,
                ),
              PizzaInformation(
                pizza: _pizza,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
