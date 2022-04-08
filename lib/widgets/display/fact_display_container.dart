import 'package:flutter/material.dart';
import 'package:statementmanager/constants/constants.dart';
import 'package:statementmanager/models/fact.dart';

import '../../provider/device_type_provider.dart';

/// Container to display a single [Fact] in detail.
//ignore: must_be_immutable
class FactDisplayContainer extends StatelessWidget {
  const FactDisplayContainer({
    Key? key,
    required this.fact,
  }) : super(key: key);

  /// The fact to be displayed.
  final Fact fact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
      // The grey background container.
      child: Container(
        alignment: Alignment.topLeft,
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: DesignColors.lightGrey,
        ),
        child: FractionallySizedBox(
          widthFactor: 1.1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display [fact.factText] and a label "Fakt".
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xFF0999bc),
                          ),
                          child: Text(
                            fact.factText,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: DesignColors.lightGrey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color(0xFF009E74),
                      ),
                      child: Text(
                        "Fakt",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                  ),
                ],
              ),
              // Display more information.
              Padding(
                padding: const EdgeInsets.all(20),
                child: Flex(
                  direction: DeviceType.width(context) < 400
                      ? Axis.vertical
                      : Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Author.
                        Row(
                          children: [
                            const Icon(Icons.person),
                            Text(fact.factAuthor),
                          ],
                        ),
                        DeviceType.width(context) < 400
                            ? const SizedBox.shrink()
                            : const Divider(
                                height: 20,
                              ),
                        // Media.
                        Row(
                          children: [
                            const Icon(Icons.newspaper),
                            Text(fact.factMedia),
                          ],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date.
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            Text(fact.dateAsString()),
                          ],
                        ),
                        DeviceType.width(context) < 400
                            ? const SizedBox.shrink()
                            : const Divider(
                                height: 20,
                              ),
                        // Language.
                        Row(
                          children: [
                            const Icon(Icons.language),
                            Text(fact.factLanguage),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
