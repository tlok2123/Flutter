import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math';
import 'dart:core';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';

  void _onButtonPressed(String text) {
    setState(() {
      if (text == '=') {
        _calculateResult();
      } else if (text == 'C') {
        _clearInput();
      } else if (text == 'CE') {
        _clearEntry();
      } else if (text == '⌫') {
        _deleteLastCharacter();
      } else if (text == '1/x') {
        _calculateInverse();
      } else if (text == 'x²') {
        _calculateSquare();
      } else if (text == '√x') {
        _calculateSquareRoot();
      } else if (text == '%') {
        _calculatePercentage();
      }
      else if (text == '×') {
        _input += '*';
      } else if (text == '÷') {
        _input += '/';
      }else {
        if (_result.isNotEmpty) {
          _input = _result;
          _result = '';
        }
        _input += text;
      }
    });
  }

  void _clearInput() {
    setState(() {
      _input = '';
      _result = '';
    });
  }

  void _clearEntry() {
    setState(() {
      _input = '';
    });
  }

  void _deleteLastCharacter() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }

  void _calculateInverse() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(_input);
      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);
      setState(() {
        _result = (1 / result).toString();
      });
    } catch (exception) {
      setState(() {
        _result = 'Invalid input';
      });
    }
  }

  void _calculateSquare() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(_input);
      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);
      setState(() {
        _result = (result * result).toString();
      });
    } catch (exception) {
      setState(() {
        _result = 'Invalid input';
      });
    }
  }

  void _calculateSquareRoot() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(_input);
      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);
      setState(() {
        _result = (sqrt(result)).toString();
      });
    } catch (exception) {
      setState(() {
        _result = 'Invalid input';
      });
    }
  }

  void _calculatePercentage() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(_input);
      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);
      setState(() {
        _result = (result / 100).toString();
      });
    } catch (exception) {
      setState(() {
        _result = 'Invalid input';
      });
    }
  }

  void _calculateResult() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(_input);
      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel) as double;
      setState(() {
        _result = result.toStringAsFixed(result % 1 == 0 ? 0 : 2);
      });
    } catch (exception) {
      setState(() {
        _result = 'Invalid input';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vũ Thành Lộc'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _input,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _result,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children:[
              Expanded(
                child: Row(
                  children: [
                    _buildFunctionButton('%'),
                    _buildFunctionButton('CE'),
                    _buildFunctionButton('C'),
                    _buildFunctionButton('⌫'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildFunctionButton('1/x'),
                    _buildFunctionButton('x²'),
                    _buildFunctionButton('√x'),
                    _buildFunctionButton('÷'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildNumberButton('7'),
                    _buildNumberButton('8'),
                    _buildNumberButton('9'),
                    _buildFunctionButton('×'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildNumberButton('4'),
                    _buildNumberButton('5'),
                    _buildNumberButton('6'),
                    _buildFunctionButton('-'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildNumberButton('1'),
                    _buildNumberButton('2'),
                    _buildNumberButton('3'),
                    _buildFunctionButton('+'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildFunctionButton('+/-'),
                    _buildNumberButton('0'),
                    _buildNumberButton('.'),
                    _buildFunctionButton('='),
                  ],
                ),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionButton(String text) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            _onButtonPressed(text);
          },
          child: Text(text),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String text) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            _onButtonPressed(text);
          },
          child: Text(text),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CalculatorScreen(),
  ));
}