import 'package:flutter/material.dart';
import 'package:statementmanager/models/fact.dart';
import 'package:statementmanager/widgets/display/display_text_sizable.dart';

//ignore: must_be_immutable
class FactDisplayContainer extends StatelessWidget {
  const FactDisplayContainer({
    Key? key,
    required this.fact,
  }) : super(key: key);

  final Fact fact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizableDisplayText(
            text: fact.factText,
            size: 20,
            icon: Icons.chat,
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: SizableDisplayText(
                  text: fact.factAuthor,
                  icon: Icons.person,
                ),
              ),
              Flexible(
                child: SizableDisplayText(
                    text: fact.factMedia, icon: Icons.newspaper),
              ),
            ]),
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: SizableDisplayText(
                  text: fact.factLanguage,
                  icon: Icons.language,
                ),
              ),
              Flexible(
                child: SizableDisplayText(
                  text: fact.factDay.toString() +
                      "." +
                      fact.factMonth.toString() +
                      "." +
                      fact.factYear.toString(),
                  icon: Icons.calendar_month_outlined,
                ),
              ),
            ]),
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: SizableDisplayText(
                  text: fact.factLink,
                  icon: Icons.link,
                ),
              ),
            ]),
          ),
          const Divider(
            height: 20,
            thickness: 4,
          ),
        ],
      ),
    );
  }
}
