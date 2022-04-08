


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
<p>If a widget's <a href="../../widgets_editable_text_field_container/TextFieldContainer/build.md">build</a> method is to depend on anything else, use a
<a href="https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html">StatefulWidget</a> instead.</p>
<p>See also:</p>
<ul>
<li><a href="https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html">StatelessWidget</a>, which contains the discussion on performance considerations.</li>
</ul>



## Implementation

```dart
@override
Widget build(BuildContext context) {
  return ValueListenableBuilder(
    valueListenable: textController,
    builder: (context, TextEditingValue value, __) {
      if (autoCompleteList != null) {
        return Container(
          color: color,
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.headline2,
                  )),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  child: Autocomplete(
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      return TextField(
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        style: Theme.of(context).textTheme.headline2,
                      );
                    },
                    optionsBuilder: (TextEditingValue val) {
                      textController.text = val.text;
                      if (val.text == "") {
                        return const Iterable<String>.empty();
                      }
                      return autoCompleteList!.where((String option) {
                        return option
                            .toLowerCase()
                            .startsWith(val.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      textController.text = selection;
                    },
                    initialValue: textController.value,
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (inputFormatter == null) {
        return Container(
          color: color,
          padding: const EdgeInsets.all(5),
          child: TextField(
            style: Theme.of(context).textTheme.headline2,
            maxLines: null,
            controller: textController,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              errorText: errorCallback(textController),
            ),
          ),
        );
      } else {
        return Container(
          color: color,
          padding: const EdgeInsets.all(5),
          child: TextField(
            style: Theme.of(context).textTheme.headline2,
            maxLines: null,
            controller: textController,
            inputFormatters: [inputFormatter!],
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              errorText: errorCallback(textController),
            ),
          ),
        );
      }
    },
  );
}
```







