import 'package:calculator/models/pad_item.dart';
import 'package:calculator/widgets/pad.dart';
import 'package:calculator/widgets/theme_switcher.dart';
import 'package:calculator/widgets/viewer.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<PadItem> pads = const [
    PadItem(
      label: "AC",
      type: PadType.clear,
    ),
    PadItem(
      label: "+/-",
      type: PadType.sign,
    ),
    PadItem(
      label: "%",
      type: PadType.percentage,
    ),
    PadItem(
      label: "÷",
      type: PadType.operator,
    ),
    PadItem(
      label: "7",
      type: PadType.number,
    ),
    PadItem(
      label: "8",
      type: PadType.number,
    ),
    PadItem(
      label: "9",
      type: PadType.number,
    ),
    PadItem(
      label: "×",
      type: PadType.operator,
    ),
    PadItem(
      label: "4",
      type: PadType.number,
    ),
    PadItem(
      label: "5",
      type: PadType.number,
    ),
    PadItem(
      label: "6",
      type: PadType.number,
    ),
    PadItem(
      label: "-",
      type: PadType.operator,
    ),
    PadItem(
      label: "1",
      type: PadType.number,
    ),
    PadItem(
      label: "2",
      type: PadType.number,
    ),
    PadItem(
      label: "3",
      type: PadType.number,
    ),
    PadItem(
      label: "+",
      type: PadType.operator,
    ),
    PadItem(
      label: "0",
      type: PadType.number,
    ),
    PadItem(
      label: ".",
      type: PadType.number,
    ),
    PadItem(
      label: "=",
      type: PadType.answer,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    double screenHeight = mq.size.height - mq.viewPadding.top;
    // pads take 55% of the screen height;
    double padHeight = screenHeight * 0.55;

    double width = mq.size.width;
    double horizontalSpacing = 15;
    double padWidth = (width / 4) - horizontalSpacing;
    // print("width :$width.... $padWidth");

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(height: screenHeight - padHeight, child: const Viewer()),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: padHeight,
                // color: Colors.red,
                // padding: EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  runSpacing: padHeight * 0.05,
                  spacing: horizontalSpacing,
                  children: pads
                      .map(
                        (pad) => SizedBox(
                          width: pads.last == pad ? padWidth * 2 : padWidth,
                          height: padHeight * 0.15, // 15% of padHeight
                          child: Pad(padItem: pad),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const Positioned(
              top: 16,
              left: 16,
              child: ThemeModeSwitcher(),
            ), // The theme mode switcher
          ],
        ),
      ),
    );
  }
}
