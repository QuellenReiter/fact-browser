import 'package:flutter/material.dart';

class SizableDisplayText extends StatelessWidget {
  const SizableDisplayText({
    Key? key,
    required this.text,
    this.icon = null,
    this.size = 14,
  }) : super(key: key);
  final IconData? icon;
  final String text;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        // decoration: BoxDecoration(
        //   borderRadius: const BorderRadius.all(Radius.circular(10)),
        //   border:
        //       Border.all(color: Color.fromARGB(183, 230, 230, 230), width: 1),
        // ),
        padding: const EdgeInsets.all(15),
        color: const Color(0x45383838),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(icon, size: size.toDouble() + 4),
              ),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: size.toDouble(),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
