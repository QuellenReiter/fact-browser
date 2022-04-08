


# Fact class






    *[<Null safety>](https://dart.dev/null-safety)*



<p>A class to hold information of a Factcheck.</p>



## Constructors

[Fact](../models_fact/Fact/Fact.md) ([String](https://api.flutter.dev/flutter/dart-core/String-class.html) factText, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) factAuthor, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) factYear, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) factMonth, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) factDay, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) factLanguage, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) factLink, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) factMedia, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? objectId, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? factArchivedLink)

Default constructor.    

[Fact.empty](../models_fact/Fact/Fact.empty.md) ()

Construct an empty <a href="../models_fact/Fact-class.md">Fact</a>.    

[Fact.fromMap](../models_fact/Fact/Fact.fromMap.md) ([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>? map)

Construct a <a href="../models_fact/Fact-class.md">Fact</a> from a <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> containing all fields of the <a href="../models_fact/Fact-class.md">Fact</a>.    


## Properties

##### [factArchivedLink](../models_fact/Fact/factArchivedLink.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)?



An archived version of the link to the factcheck.   
_read / write_



##### [factAuthor](../models_fact/Fact/factAuthor.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The author.   
_read / write_



##### [factDay](../models_fact/Fact/factDay.md) &#8596; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The day of publication.   
_read / write_



##### [factLanguage](../models_fact/Fact/factLanguage.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The language of the factcheck article.   
_read / write_



##### [factLink](../models_fact/Fact/factLink.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The link to the factcheck.   
_read / write_



##### [factMedia](../models_fact/Fact/factMedia.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The media publishing the factcheck.   
_read / write_



##### [factMonth](../models_fact/Fact/factMonth.md) &#8596; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The month of publication.   
_read / write_



##### [factText](../models_fact/Fact/factText.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The summary of the factcheck.   
_read / write_



##### [factYear](../models_fact/Fact/factYear.md) &#8596; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The year of publication.   
_read / write_



##### [hashCode](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html) &#8594; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The hash code for this object. [...](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html)  
_read-only, inherited_



##### [objectId](../models_fact/Fact/objectId.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)?



The ID of the factcheck in the database.   
_read / write_



##### [runtimeType](https://api.flutter.dev/flutter/dart-core/Object/runtimeType.html) &#8594; [Type](https://api.flutter.dev/flutter/dart-core/Type-class.html)



A representation of the runtime type of the object.   
_read-only, inherited_




## Methods

##### [dateAsString](../models_fact/Fact/dateAsString.md)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Return the <a href="../models_fact/Fact/factDay.md">Fact.factDay</a>, <a href="../models_fact/Fact/factMonth.md">Fact.factMonth</a> and <a href="../models_fact/Fact/factYear.md">Fact.factYear</a> as
<a href="https://api.flutter.dev/flutter/dart-core/String-class.html">String</a> like so dd/mm/yyyy. [...](../models_fact/Fact/dateAsString.md)  




##### [noSuchMethod](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)([Invocation](https://api.flutter.dev/flutter/dart-core/Invocation-class.html) invocation) dynamic



Invoked when a non-existent method or property is accessed. [...](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)  
_inherited_



##### [toMap](../models_fact/Fact/toMap.md)() [Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>



Convert a <a href="../models_fact/Fact-class.md">Fact</a> back to its <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> representation.   




##### [toString](https://api.flutter.dev/flutter/dart-core/Object/toString.html)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A string representation of this object. [...](https://api.flutter.dev/flutter/dart-core/Object/toString.html)  
_inherited_




## Operators

##### [operator ==](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)([Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) other) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



The equality operator. [...](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)  
_inherited_











