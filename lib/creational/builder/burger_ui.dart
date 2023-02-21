
import 'package:flutter/material.dart';

import 'builder.dart';
import 'builder_base.dart';
import 'burger.dart';
import 'burger_maker.dart';

class BurgerMenuItem {
  String label;
  BurgerBuilderBase burgerBuilder;
  BurgerMenuItem({
    required this.label,
    required this.burgerBuilder,
  });

}

class BuilderExample extends StatefulWidget {
  const BuilderExample({super.key});

  @override
  State<StatefulWidget> createState() => _BuilderExampleState();
}

class _BuilderExampleState extends State<BuilderExample> {
  final BurgerMaker _burgerMaker = BurgerMaker(HamburgerBuilder());
  final List<BurgerMenuItem> _burgerMenuItems = [];

  late BurgerMenuItem _selectedBurgerMenuItem;
  late Burger _selectedBurger;

  @override
  void initState() {
    super.initState();

    _burgerMenuItems.addAll([
      BurgerMenuItem(
        label: 'Hamburger',
        burgerBuilder: HamburgerBuilder(),
      ),
      BurgerMenuItem(
        label: 'Cheeseburger',
        burgerBuilder: CheeseburgerBuilder(),
      ),
      BurgerMenuItem(
        label: 'Big Mac\u00AE',
        burgerBuilder: BigMacBuilder(),
      ),
      BurgerMenuItem(
        label: 'McChicken\u00AE',
        burgerBuilder: McChickenBuilder(),
      )
    ]);

    _selectedBurgerMenuItem = _burgerMenuItems[0];
    _selectedBurger = _prepareSelectedBurger();
  }

  Burger _prepareSelectedBurger() {
    _burgerMaker.prepareBurger();

    return _burgerMaker.getBurger();
  }

  void _onBurgerMenuItemChanged(BurgerMenuItem selectedItem) {
    setState(() {
      _selectedBurgerMenuItem = selectedItem;
      _burgerMaker.changeBurgerBuilder(selectedItem.burgerBuilder);
      _selectedBurger = _prepareSelectedBurger();
    });
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Select menu item:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              DropdownButton(
                value: _selectedBurgerMenuItem,
                items: _burgerMenuItems
                    .map<DropdownMenuItem<BurgerMenuItem>>(
                      (BurgerMenuItem item) => DropdownMenuItem(
                        value: item,
                        child: Text(item.label),
                      ),
                    )
                    .toList(),
                onChanged: (se) {
                  _onBurgerMenuItemChanged(se ?? _selectedBurgerMenuItem);
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Text(
                    'Information:',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              burgerInformationColumn(burger: _selectedBurger),
            ],
          ),
        ),
      ),
    );
  }
  
  Column burgerInformationColumn({required Burger burger}) {
        return Column(
      children: [
        Text('Price: ${burger.getFormattedPrice()}'),
        Text('Ingredient: ${burger.getFormattedIngredients()}'),
        Text('Allergens: ${burger.getFormattedAllergens()}'),
      ],
    );
  }
}


