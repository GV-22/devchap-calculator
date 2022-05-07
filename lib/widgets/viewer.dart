import 'dart:async';

import 'package:calculator/models/pad_item.dart';
import 'package:calculator/utils/event.dart';
import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class Viewer extends StatefulWidget {
  const Viewer({Key? key}) : super(key: key);

  @override
  State<Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  late StreamSubscription<EventData> _listener;
  String calcul = "";
  String result = "";
  List<String> operators = ["+", "-", "×", "÷"];
  final opRegx = RegExp('/+|÷|×|-');

  // Map<String, dynamic> operationResult = {};

  @override
  void initState() {
    super.initState();

    _listener = EventBusController.eventBus.on<EventData>().listen((event) {
      // print("[EVENT] $event");
      _updateExpression(event);
    });
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }

  void _updateExpression(EventData event) {
    final padItem = event.padItem;
    final data = event.data;
    String exp = calcul;
    bool autoCompute = false;
    bool compute = false;
    // split the expression by operators
    final List<String> splitedByOp = exp.split(opRegx);

    switch (padItem.type) {
      case PadType.number:
        // the maximum length of each operand is 15,
        // Eg: A+B, A and B cannot be bigger than 1.10e14
        print("splitedByOp $splitedByOp");
        if (splitedByOp.last.length == 15) return;
        // auto compute operation without waiting the user to click on equality button
        if (splitedByOp.length != 1) autoCompute = true;

        exp = "$exp${padItem.label}";
        break;

      case PadType.percentage:
        if (exp.isEmpty && result.isEmpty) return;

        autoCompute = true;
        exp = "$exp${padItem.label}";
        break;

      case PadType.operator:
        // if there is no expression, the user cannot add an operator
        if (exp.isEmpty) return;

        final lastChar = exp[exp.length - 1];
        if (operators.contains(lastChar)) {
          // if the expression ends with an operator and this operator is different
          // with the new pressed, then switch the lastChar with the new operator
          // This is to avoid having two operators following each other like (2+-6)
          exp = exp.substring(0, exp.length - 1);
        }

        exp = "$exp${padItem.label}";
        break;

      case PadType.sign:
        break;

      case PadType.clear:
        if (data == "clearAll") {
          exp = "";
          result = "";
        } else {
          if (exp.isEmpty) return;
          // remove the last character of the expression
          exp = exp.substring(0, exp.length - 1);
          exp.isEmpty ? result = "" : autoCompute = true;
        }
        break;
      case PadType.answer:
        if (exp.isEmpty) return;

        compute = true;
        break;

      default:
        throw "Invalid pad type provided ${padItem.type}";
    }

    setState(() {
      calcul = exp;
      if (autoCompute) {
        result = _computeExpression(exp);
      }
      if (compute) {
        result = calcul;
        calcul = _computeExpression(exp);
      }
    });
  }

  String _computeExpression(String exp) {
    // replace all ui characters by the ones that Expression library works with
    String _formatedExp = exp.replaceAll("×", "*");
    _formatedExp = _formatedExp.replaceAll("%", "*0.01");
    _formatedExp = _formatedExp.replaceAll("÷", "/");

    // print("exp '$exp' ====> formated '$_formatedExp'");
    Expression? expression = Expression.tryParse(_formatedExp);

    // if the operation is not valid
    if (expression == null) {
      return "invalid operation";
    }

    const expContext = {"": ""};
    const evaluator = ExpressionEvaluator();
    final _result = evaluator.eval(expression, expContext);

    print("result: $_result, result is: ${_result.runtimeType}");

    if (_result is double && _result.isInfinite) {
      return "impossible de diviser par zéro";
    }

    return _result.toString();
  }

  bool isValidNum(String value) {
    return num.tryParse(value) != null;
  }

  // String _formatValue(String value) {
  //   final formated = NumberFormat.decimalPattern().format(num.parse(value));
  //   // final test = NumberFormat.decimalPattern().format(double.parse("88888x8888"));
  //   print("intlNumberParse $formated");

  //   return formated;
  // }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double calculFontSize = calcul.length > 20 ? 26 : 34;
    final double resultFontSize = result.length > 7 ? 36 : 56;
    // final double resultFontSize = result.length > 15 ? 24 : result.length > 7 ? 16: 56;
    final isValid = isValidNum(result);

    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 70, top: 20),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              result, // TODO format the value with thousand seperator
              textAlign: TextAlign.end,
              style: TextStyle(
                color: isValid
                    ? colorScheme.secondary
                    : colorScheme.secondary.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: isValid ? resultFontSize : 14,
              ),
            ),

            // calcul
            const SizedBox(height: 10),
            Text(
              calcul,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: colorScheme.secondary,
                fontWeight: FontWeight.w500,
                fontSize: calculFontSize,
              ),
            ),
            // result
          ],
        ),
      ),
    );
  }
}
