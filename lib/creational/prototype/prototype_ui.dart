import 'package:flutter/material.dart';
import 'shape_base.dart';
import 'shapes.dart';

class PrototypeExample extends StatefulWidget {
  const PrototypeExample({super.key});

  @override
  State<StatefulWidget> createState() => _PrototypeExampleState();
}

class _PrototypeExampleState extends State<PrototypeExample> {
  final Shape _circle = Circle.initial();
  final Shape _rectangle = Rectangle.initial();

   Shape _circleClone = Circle.initial();
   Shape _rectangleClone = Circle.initial();

  void _randomiseCircleProperties() {
    setState(() {
      _circle.randomiseProperties();
    });
  }

  void _cloneCircle() {
    setState(() {
      _circleClone = _circle.clone();
    });
  }

  void _randomiseRectangleProperties() {
    setState(() {
      _rectangle.randomiseProperties();
    });
  }

  void _cloneRectangle() {
    setState(() {
      _rectangleClone = _rectangle.clone();
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
            children: <Widget>[
              shapeColumn(
                shape: _circle,
                shapeClone: _circleClone,
                onClonePressed: _cloneCircle,
                onRandomisePropertiesPressed: _randomiseCircleProperties,
              ),
              const Divider(),
              shapeColumn(
                shape: _rectangle,
                shapeClone: _rectangleClone,
                onClonePressed: _cloneRectangle,
                onRandomisePropertiesPressed: _randomiseRectangleProperties,
              ),
            ],
          ),
        ),
      ),
    );
  }

  shapeColumn(
      {required Shape shape,
      required Shape shapeClone,
      required void Function() onClonePressed,
      required void Function() onRandomisePropertiesPressed}) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                const Text('Original Shape'),
                shape.render(),
              ],
            ),
            Column(
              children: [
                const Text('Clone Shape'),
                shapeClone.render(),
              ],
            )
          ],
        ),
        TextButton(
          onPressed: onRandomisePropertiesPressed,
          child: const Text('Randomise Properties'),
        ),
        TextButton(
          onPressed: onClonePressed,
          child: const Text('Clone'),
        ),
      ],
    );
  }
}
