import 'package:flutter/material.dart';

class SizableDisplayText extends StatelessWidget {
  const SizableDisplayText({Key? key, required this.text, this.size = 14})
      : super(key: key);

  final String text;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      padding: const EdgeInsets.all(15),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: size.toDouble(),
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
