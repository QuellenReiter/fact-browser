import 'package:flutter/material.dart';
import 'package:statementmanager/constants/constants.dart';
import 'package:statementmanager/utilities/utilities.dart';

class CorrectnessBadge extends StatelessWidget {
  const CorrectnessBadge({Key? key, required this.correctnessValue})
      : super(key: key);
  final String correctnessValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: correctnessValue != CorrectnessCategory.correct
            ? DesignColors.red
            : DesignColors.green,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          hoverColor: correctnessValue != CorrectnessCategory.correct
              ? const Color.fromARGB(255, 176, 77, 1)
              : const Color.fromARGB(255, 0, 121, 89),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              correctnessValue,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          onTap: () => showModalBottomSheet<void>(
            context: context,
            isDismissible: true,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 1000,
                    ),
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(Icons.close),
                                iconSize: 50,
                                onPressed: () =>
                                    Navigator.of(context).pop(context),
                              ),
                            ),
                            SelectableText(
                              "Unsere Bewertungsskala",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(color: DesignColors.green),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: DesignColors.green,
                                  ),
                                  child: SelectableText(
                                    "Richtig",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                Flexible(
                                  child: SelectableText(
                                    "Die Behauptungen oder Aussagen sind richtig.",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: DesignColors.red,
                                  ),
                                  child: SelectableText(
                                    "Manipuliert",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                Flexible(
                                  child: SelectableText(
                                    "Diese Aussage ist Falsch und bewusst manipulliert worden.",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: DesignColors.red,
                                  ),
                                  child: SelectableText(
                                    "Falscher Kontext",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                Flexible(
                                  child: SelectableText(
                                    "Ein Foto oder Video zeigt nicht das, was behauptet wird, ist veraltet oder an einem anderen Ort entstanden. ",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: DesignColors.red,
                                  ),
                                  child: SelectableText(
                                    "Irreführend",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                Flexible(
                                  child: SelectableText(
                                    "Diese Aussage ",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: DesignColors.red,
                                  ),
                                  child: SelectableText(
                                    "Frei Erfunden",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                Flexible(
                                  child: SelectableText(
                                    "Zitate, Behauptungen, Zahlen, Geschehnisse oder Personen sind erfunden.",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: DesignColors.red,
                                  ),
                                  child: SelectableText(
                                    "Unbelegt",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                Flexible(
                                  child: SelectableText(
                                    "Die Behauptungen oder Aussagen sind nicht belegbar.",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
