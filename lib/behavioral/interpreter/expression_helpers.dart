import 'dart:collection';

import 'expressions/nonterminal/add.dart';
import 'expressions/nonterminal/multiply.dart';
import 'expressions/nonterminal/subtract.dart';
import 'expressions/terminal/number.dart';
import 'iexpression.dart';

class ExpressionHelpers {
  const ExpressionHelpers._();

  static final List<String> _operators = ['+', '-', '*'];

  static IExpression buildExpressionTree(String postfixExpression) {
    final expressionStack = ListQueue<IExpression>();

    for (final symbol in postfixExpression.split(' ')) {
      if (_isOperator(symbol)) {
        final IExpression rightExpression = expressionStack.removeLast();
        final IExpression leftExpression = expressionStack.removeLast();
        final IExpression nonterminalExpression =
            _getNonterminalExpression(symbol, leftExpression, rightExpression);

        expressionStack.addLast(nonterminalExpression);
      } else {
        final numberExpression = Number(int.parse(symbol));

        expressionStack.addLast(numberExpression);
      }
    }

    return expressionStack.single;
  }

  static bool _isOperator(String symbol) {
    return _operators.contains(symbol);
  }

  static IExpression _getNonterminalExpression(
    String symbol,
    IExpression leftExpression,
    IExpression rightExpression,
  ) {
    IExpression expression;

    switch (symbol) {
      case '+':
        expression = Add(leftExpression, rightExpression);
        break;
      case '-':
        expression = Subtract(leftExpression, rightExpression);
        break;
      case '*':
        expression = Multiply(leftExpression, rightExpression);
        break;
      default:
        throw Exception('Expression is not defined.');
    }

    return expression;
  }
}
