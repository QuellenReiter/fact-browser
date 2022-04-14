import 'package:flutter/material.dart';
import 'package:statementmanager/constants/constants.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/utilities/utilities.dart';

/// Brief information display of a single [Statement].
class StatementCard extends StatefulWidget {
  const StatementCard(
      {Key? key, required this.statement, required this.onTapped})
      : super(key: key);

  /// The [Statement] to be displayed.
  final Statement statement;

  /// Stores if user tapped on this [StatementCard] and notifies the navigation.
  final ValueChanged<Statement> onTapped;

  @override
  State<StatementCard> createState() => _StatementCardState();
}

class _StatementCardState extends State<StatementCard>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List of the Media publishing the [Facts] of this [Statement].
    List<Widget> factcheckMediaList = List.generate(
      widget.statement.statementFactchecks.facts.length,
      (int i) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.fact_check,
            color: DesignColors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 3),
            child: Text(
              widget.statement.statementFactchecks.facts[i].factMedia,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
    return FadeTransition(
      opacity:
          CurvedAnimation(curve: Curves.easeIn, parent: controller..forward()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        // The grey background box.
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: DesignColors.lightGrey,
          // Make it clickable.
          child: InkWell(
            hoverColor: Colors.grey[300],
            highlightColor: Colors.grey[400],
            splashColor: Colors.grey[600],
            onTap: () => widget.onTapped(widget.statement),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display Statementtext.
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.statement.statementText,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Display correctness.
                        Container(
                          decoration: BoxDecoration(
                            color: widget.statement.statementCorrectness ==
                                    CorrectnessCategory.correct
                                ? const Color(0xFF009e73)
                                : const Color(0xFFd55e00),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            widget.statement.statementCorrectness,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: DesignColors.lightGrey),
                          ),
                        ),
                        // Display Media and date.
                        Text(
                          widget.statement.statementMedia +
                              ', ' +
                              widget.statement.dateAsString(),
                          style: Theme.of(context).textTheme.bodyText2,
                        )
                      ],
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(
                          width: 40,
                          margin: const EdgeInsets.only(right: 10),
                          child: const Divider(
                            color: Colors.grey,
                            height: 40,
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Faktenchecks",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Divider(
                            color: Colors.grey,
                            height: 40,
                          )),
                    ),
                  ]),
                  // Display list of Factcheck Media.
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: factcheckMediaList,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
