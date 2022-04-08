


# dispose method




    *[<Null safety>](https://dart.dev/null-safety)*




void dispose
()





<p>Call dispose funktion of all <a href="../../models_fact/FactController-class.md">FactController</a>.</p>



## Implementation

```dart
void dispose() {
  for (FactController c in controllers) {
    c.dispose();
  }
}
```







