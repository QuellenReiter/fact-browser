


# build method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html) build
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)

_override_



<p>Describes the part of the user interface represented by this widget.</p>
<p>The framework calls this method when this widget is inserted into the tree
in a given <a href="https://api.flutter.dev/flutter/widgets/BuildContext-class.html">BuildContext</a> and when the dependencies of this widget change
(e.g., an <a href="https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html">InheritedWidget</a> referenced by this widget changes). This
method can potentially be called in every frame and should not have any side
effects beyond building a widget.</p>
<p>The framework replaces the subtree below this widget with the widget
returned by this method, either by updating the existing subtree or by
removing the subtree and inflating a new subtree, depending on whether the
widget returned by this method can update the root of the existing
subtree, as determined by calling <a href="https://api.flutter.dev/flutter/widgets/Widget/canUpdate.html">Widget.canUpdate</a>.</p>
<p>Typically implementations return a newly created constellation of widgets
that are configured with information from this widget's constructor and
from the given <a href="https://api.flutter.dev/flutter/widgets/BuildContext-class.html">BuildContext</a>.</p>
<p>The given <a href="https://api.flutter.dev/flutter/widgets/BuildContext-class.html">BuildContext</a> contains information about the location in the
tree at which this widget is being built. For example, the context
provides the set of inherited widgets for this location in the tree. A
given widget might be built with multiple different <a href="https://api.flutter.dev/flutter/widgets/BuildContext-class.html">BuildContext</a>
arguments over time if the widget is moved around the tree or if the
widget is inserted into the tree in multiple places at once.</p>
<p>The implementation of this method must only depend on:</p>
<ul>
<li>the fields of the widget, which themselves must not change over time,
and</li>
<li>any ambient state obtained from the <code>context</code> using
<a href="https://api.flutter.dev/flutter/widgets/BuildContext/dependOnInheritedWidgetOfExactType.html">BuildContext.dependOnInheritedWidgetOfExactType</a>.</li>
</ul>
<p>If a widget's <a href="../../screens_detail_screen/DetailScreen/build.md">build</a> method is to depend on anything else, use a
<a href="https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html">StatefulWidget</a> instead.</p>
<p>See also:</p>
<ul>
<li><a href="https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html">StatelessWidget</a>, which contains the discussion on performance considerations.</li>
</ul>



## Implementation

```dart
@override
Widget build(BuildContext context) {
  // List of widgets displaying all factchecks.
  List<Widget> factContainers = List.generate(
    statement.statementFactchecks.facts.length,
    (int i) => FactDisplayContainer(
      fact: statement.statementFactchecks.facts[i],
    ),
  );

  return Scaffold(
    appBar: MainAppBar(
      title: title,
      onLogin: onLogin,
      loggedIn: isLoggedIn,
    ),
    body: Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        constraints: const BoxConstraints(maxWidth: 1000),
        height: DeviceType.height(context),
        // Scrollable container displaying all the information.
        child: ListView(
          clipBehavior: Clip.none,
          shrinkWrap: true,
          children: [
            // The backbutton.
            FractionallySizedBox(
              widthFactor: 1.1,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, top: 20, bottom: 20),
                child: Wrap(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new),
                      label: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Text(
                          "zurück zur Suche",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              // Grey background box.
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
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: FractionallySizedBox(
                              widthFactor:
                                  DeviceType.width(context) < 600 ? 0.8 : 0.5,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  // The image with rounded edges and cropped
                                  // to 4:3 ratio.
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: Container(
                                          decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            statement.statementPictureURL !=
                                                    ""
                                                ? statement
                                                    .statementPictureURL
                                                    .replaceAll(
                                                        "https%3A%2F%2Fparsefiles.back4app.com%2FFeP6gb7k9R2K9OztjKWA1DgYhubqhW0yJMyrHbxH%2F",
                                                        "")
                                                : "https://quellenreiter.app/assets/logo-pink.png",
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                    ),
                                  ),
                                  // Display [statement.samplePictureCopyright]
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    color: const Color.fromARGB(61, 0, 0, 0),
                                    child: Text(
                                      statement.samplePictureCopyright.trim(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Display [statement.statementText] and
                          // [statement.statementCorrectness]
                          Align(
                            alignment: Alignment.centerRight,
                            child: FractionallySizedBox(
                              widthFactor: 0.6,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color(0xFF0999bc),
                                      ),
                                      child: Text(
                                        statement.statementText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                                color:
                                                    DesignColors.lightGrey),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        color: statement
                                                    .statementCorrectness !=
                                                CorrectnessCategory.correct
                                            ? const Color(0xFFD55C00)
                                            : const Color(0xFF009E74),
                                      ),
                                      child: Text(
                                        statement.statementCorrectness,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Author
                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    Text(statement.statementAuthor),
                                  ],
                                ),
                                DeviceType.width(context) < 400
                                    ? const SizedBox.shrink()
                                    : const Divider(
                                        height: 20,
                                      ),
                                // Media and Mediatype
                                Row(
                                  children: [
                                    const Icon(Icons.newspaper),
                                    Text(statement.statementMedia +
                                        ' | ' +
                                        statement.statementMediatype),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Date
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month),
                                    Text(statement.dateAsString()),
                                  ],
                                ),
                                DeviceType.width(context) < 400
                                    ? const SizedBox.shrink()
                                    : const Divider(
                                        height: 20,
                                      ),
                                // Language
                                Row(
                                  children: [
                                    const Icon(Icons.language),
                                    Text(statement.statementLanguage),
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
            ),
            // Display all [statement.factChecks]
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: factContainers,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
```







