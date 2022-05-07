import 'package:calculator/models/pad_item.dart';
import 'package:calculator/utils/event.dart';
import 'package:flutter/material.dart';

class Pad extends StatelessWidget {
  final PadItem padItem;

  const Pad({required this.padItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const fontweight = FontWeight.bold;
    const double fontSize = 24;
    final colorScheme = Theme.of(context).colorScheme;

    final _textSyle = TextStyle(
      color: colorScheme.secondary,
      fontWeight: fontweight,
      fontSize: fontSize,
    );

    switch (padItem.type) {
      case PadType.operator:
        return GestureDetector(
          onTap: () {
            EventBusController.fireEvent(EventData(padItem: padItem));
          },
          child: CircleAvatar(
            backgroundColor: colorScheme.tertiary,
            child: Text(padItem.label, style: _textSyle),
          ),
        );

      case PadType.answer:
        return ElevatedButton(
          onPressed: () {
            EventBusController.fireEvent(EventData(padItem: padItem));
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(0),
            backgroundColor:
                MaterialStateProperty.all<Color>(colorScheme.tertiary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          child: Text(padItem.label, style: _textSyle),
        );

      case PadType.clear:
        return TextButton(
          onPressed: () {
            EventBusController.fireEvent(EventData(padItem: padItem));
          },
          onLongPress: () {
            EventBusController.fireEvent(
                EventData(padItem: padItem, data: "clearAll"));
          },
          child: Text(padItem.label, style: _textSyle),
        );
      case PadType.number:
      case PadType.percentage:
      case PadType.sign:
        return TextButton(
          onPressed: () {
            EventBusController.fireEvent(EventData(padItem: padItem));
          },
          child: Text(
            padItem.label,
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: fontweight,
              fontSize: fontSize,
            ),
          ),
        );

      default:
        throw "Invalid pad type provided ${padItem.type}";
    }
  }
}
