import 'package:flutter/material.dart';

import '../ipositioned_shape.dart';

class Square implements IPositionedShape {
  final Color color;
  final double width;

  const Square({
    required this.color,
    required this.width,
  });

  double get height => width;

  @override
  Widget render(double x, double y) {
    return Positioned(
      left: x,
      bottom: y,
      child: Container(
        height: height,
        width: width,
        color: color,
      ),
    );
  }
}
