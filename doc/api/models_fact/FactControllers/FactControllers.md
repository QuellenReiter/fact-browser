


# FactControllers constructor




    *[<Null safety>](https://dart.dev/null-safety)*



FactControllers([Facts](../../models_fact/Facts-class.md) facts)


<p>Construct <a href="../../models_fact/FactControllers-class.md">FactControllers</a> from <a href="../../models_fact/Facts-class.md">Facts</a>.</p>



## Implementation

```dart
FactControllers(Facts facts) {
  for (Fact fact in facts.facts) {
    controllers.add(FactController(fact));
  }
  //add empty fact controller, if no facts given
  if (facts.facts.isEmpty) {
    controllers.add(FactController(Fact.empty()));
  }
}
```







