


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
<p>If a widget's <a href="../../widgets_statement_card/StatementCard/build.md">build</a> method is to depend on anything else, use a
<a href="https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html">StatefulWidget</a> instead.</p>
<p>See also:</p>
<ul>
<li><a href="https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html">StatelessWidget</a>, which contains the discussion on performance considerations.</li>
</ul>



## Implementation

```dart
@override
Widget build(BuildContext context) {
  // List of the Media publishing the [Facts] of this [Statement].
  List<Widget> factcheckMediaList = List.generate(
    statement.statementFactchecks.facts.length,
    (int i) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.fact_check,
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
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
                child: Text(
                  statement.statementText,
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
                        color: statement.statementCorrectness ==
                                CorrectnessCategory.correct
                            ? const Color(0xFF009e73)
                            : const Color(0xFFd55e00),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        statement.statementCorrectness,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: DesignColors.lightGrey),
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
              ),
              const Divider(
                height: 20,
                thickness: 2,
              ),
              // Display list of Factcheck Media.
              Wrap(
                children: factcheckMediaList,
              )
            ],
          ),
        ),
      ),
    ),
  );
}
```







