import 'package:flutter/material.dart';
import 'package:Memo/providers/titleProvider.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Logo extends StatelessWidget {
  final bool withBreakLine;
  final double fontSize;
  const Logo({super.key, this.withBreakLine = false, this.fontSize = 64});

  @override
  Widget build(BuildContext context) {
    final title = context.read<Titleprovider>().title;

    return withBreakLine
        ? Column(
            children: [
              GradientText(
                title[0],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
                colors: const [
                  Color(0xff1271CA),
                  Color(0xff5D21DD),
                ],
              ),
              GradientText(
                title[1],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize * 0.7,
                  fontWeight: FontWeight.bold,
                ),
                colors: const [
                  Color(0xff1271CA),
                  Color(0xff5D21DD),
                ],
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(
                title[0],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
                colors: const [
                  Color(0xff1271CA),
                  Color(0xff5D21DD),
                ],
              ),
              const SizedBox(
                width: 4,
              ),
              GradientText(
                title[1],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
                colors: const [
                  Color(0xff1271CA),
                  Color(0xff5D21DD),
                ],
              ),
            ],
          );
  }
}
