import 'dart:math';

import 'package:flutter/material.dart';

import 'shape_base.dart';

class Circle extends Shape {
  late double radius;

  Circle(super.color, this.radius);

  Circle.initial([super.color = Colors.black]) {
    radius = 50.0;
  }

  Circle.clone(Circle source) : super.clone(source) {
    radius = source.radius;
  }

  @override
  Shape clone() {
    return Circle.clone(this);
  }

  Random random = Random();
  @override
  void randomiseProperties() {
    color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1.0,
    );
    radius = random.nextInt(25).toDouble() + 25.0;
  }

  @override
  Widget render() {
    return SizedBox(
      height: 120.0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: 2 * radius,
          width: 2 * radius,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.star,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Rectangle extends Shape {
  late double height;
  late double width;

  Rectangle(super.color, this.height, this.width);

  Rectangle.initial([super.color = Colors.black]) {
    height = 100.0;
    width = 100.0;
  }

  Rectangle.clone(Rectangle source) : super.clone(source) {
    height = source.height;
    width = source.width;
  }

  @override
  Shape clone() {
    return Rectangle.clone(this);
  }

  Random random = Random();

  @override
  void randomiseProperties() {
    color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1.0,
    );
    height = random.nextInt(100).toDouble() + 50.0;
    width = random.nextInt(100).toDouble() + 50.0;
  }

  @override
  Widget render() {
    return SizedBox(
      height: 120.0,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: color,
          ),
          child: const Icon(
            Icons.star,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
