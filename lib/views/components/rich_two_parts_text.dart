import 'package:flutter/material.dart';

class RichTwoPartsText extends StatelessWidget {
  final String leftPart;
  final String rightPart;

  const RichTwoPartsText({
    Key? key,
    required this.leftPart,
    required this.rightPart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(height: 1.5),
        children: [
          TextSpan(
            text: leftPart,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TextSpan(
            text: ' $rightPart',
          )
        ],
      ),
    );
  }
}
