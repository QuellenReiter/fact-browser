import 'package:flutter/material.dart';
import 'package:fact_browser/constants/constants.dart';
import 'package:fact_browser/models/statement.dart';
import 'package:fact_browser/utilities/utilities.dart';
import 'package:transparent_image/transparent_image.dart';

/// Brief information display of a single [Statement].
class StatementCard extends StatelessWidget {
  const StatementCard(
      {Key? key, required this.statement, required this.onTapped})
      : super(key: key);

  /// The [Statement] to be displayed.
  final Statement statement;

  /// Stores if user tapped on this [StatementCard] and notifies the navigation.
  final ValueChanged<Statement> onTapped;
  @override
  Widget build(BuildContext context) {
    // List of the Media publishing the [Facts] of this [Statement].
    List<Widget> factcheckMediaList = List.generate(
      statement.statementFactchecks.facts.length,
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
              statement.statementFactchecks.facts[i].factMedia,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
    return Padding(
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
          onTap: () => onTapped(statement),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: AspectRatio(
                              aspectRatio: 4 / 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: FadeInImage.memoryNetwork(
                                  fadeInDuration:
                                      const Duration(milliseconds: 400),
                                  fadeInCurve: Curves.easeInOut,
                                  fit: BoxFit.cover,
                                  placeholder: kTransparentImage,
                                  image: statement.statementPictureURL != null
                                      ? statement.statementPictureURL!.replaceAll(
                                          "https%3A%2F%2Fparsefiles.back4app.com%2FFeP6gb7k9R2K9OztjKWA1DgYhubqhW0yJMyrHbxH%2F",
                                          "")
                                      : "https://quellenreiter.app/assets/logo-pink.png",
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          statement.statementText,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: DesignColors.black),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: DesignColors.black,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Display correctness.
                    Container(
                      decoration: BoxDecoration(
                        color: statement.statementCorrectness ==
                                CorrectnessCategory.correct
                            ? DesignColors.green
                            : DesignColors.red,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        statement.statementCorrectness ==
                                CorrectnessCategory.correct
                            ? "Fakt"
                            : "Fake",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    // Display Media and date.
                    Text(
                      statement.statementMedia +
                          ', ' +
                          statement.dateAsString(),
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
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
                      "Faktenchecks zur Aussage von:",
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
    );
  }
}
