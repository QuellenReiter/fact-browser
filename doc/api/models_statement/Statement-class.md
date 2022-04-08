


# Statement class






    *[<Null safety>](https://dart.dev/null-safety)*



<p>A class to hold information of a Statement.</p>



## Constructors

[Statement](../models_statement/Statement/Statement.md) ([String](https://api.flutter.dev/flutter/dart-core/String-class.html) statementText, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) statementAuthor, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) statementCategory, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) statementCorrectness, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) statementYear, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) statementMonth, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) statementDay, [Facts](../models_fact/Facts-class.md) statementFactchecks, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) statementLanguage, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) statementLink, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) statementMedia, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) statementMediatype, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) statementPictureURL, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) samplePictureCopyright, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) statementRectification, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? objectId)

Default constructor.    

[Statement.empty](../models_statement/Statement/Statement.empty.md) ()

Construct an empty <a href="../models_statement/Statement-class.md">Statement</a>.    

[Statement.fromMap](../models_statement/Statement/Statement.fromMap.md) ([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>? map)

Construct a <a href="../models_statement/Statement-class.md">Statement</a> from a <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> containing all fields of the
<a href="../models_statement/Statement-class.md">Statement</a>.    


## Properties

##### [hashCode](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html) &#8594; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The hash code for this object. [...](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html)  
_read-only, inherited_



##### [objectId](../models_statement/Statement/objectId.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)?



The ID of the statement in the database.   
_read / write_



##### [runtimeType](https://api.flutter.dev/flutter/dart-core/Object/runtimeType.html) &#8594; [Type](https://api.flutter.dev/flutter/dart-core/Type-class.html)



A representation of the runtime type of the object.   
_read-only, inherited_



##### [samplePictureCopyright](../models_statement/Statement/samplePictureCopyright.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The copyright text of the <a href="../models_statement/Statement/statementPictureURL.md">Statement.statementPictureURL</a>.   
_read / write_



##### [statementAuthor](../models_statement/Statement/statementAuthor.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The Author of the statement.   
_read / write_



##### [statementCategory](../models_statement/Statement/statementCategory.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The Category of the statement. One of <a href="../constants_constants/DropdownValues/categoryValues.md">DropdownValues.categoryValues</a>.   
_read / write_



##### [statementCorrectness](../models_statement/Statement/statementCorrectness.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The correctness of the statement. One of <a href="../constants_constants/DropdownValues/correctnessValues.md">DropdownValues.correctnessValues</a>.   
_read / write_



##### [statementDay](../models_statement/Statement/statementDay.md) &#8596; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The Day of the statement publication.   
_read / write_



##### [statementFactchecks](../models_statement/Statement/statementFactchecks.md) &#8596; [Facts](../models_fact/Facts-class.md)



The <a href="../models_fact/Facts-class.md">Facts</a> of the statement.   
_read / write_



##### [statementLanguage](../models_statement/Statement/statementLanguage.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The Language of the statement.   
_read / write_



##### [statementLink](../models_statement/Statement/statementLink.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The Link to the statement, mostly an archived link.   
_read / write_



##### [statementMedia](../models_statement/Statement/statementMedia.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The Media publishing the statement.   
_read / write_



##### [statementMediatype](../models_statement/Statement/statementMediatype.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The Mediatype of the statement.   
_read / write_



##### [statementMonth](../models_statement/Statement/statementMonth.md) &#8596; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The Month of the statement publication.   
_read / write_



##### [statementPictureURL](../models_statement/Statement/statementPictureURL.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The URL to a picture describing the statement.   
_read / write_



##### [statementRectification](../models_statement/Statement/statementRectification.md) &#8596; [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



Stores if the statement was corrected.   
_read / write_



##### [statementText](../models_statement/Statement/statementText.md) &#8596; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



The claim of the statement.   
_read / write_



##### [statementYear](../models_statement/Statement/statementYear.md) &#8596; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The Year of the statement publication.   
_read / write_



##### [uploadImage](../models_statement/Statement/uploadImage.md) &#8596; [Uint8List](https://api.flutter.dev/flutter/dart-typed_data/Uint8List-class.html)?



An image to be uploaded stored as bytes.   
_read / write_




## Methods

##### [dateAsString](../models_statement/Statement/dateAsString.md)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Return the <a href="../models_statement/Statement/statementDay.md">Statement.statementDay</a>, <a href="../models_statement/Statement/statementMonth.md">Statement.statementMonth</a> and
<a href="../models_statement/Statement/statementYear.md">Statement.statementYear</a> as <a href="https://api.flutter.dev/flutter/dart-core/String-class.html">String</a> like so dd/mm/yyyy. [...](../models_statement/Statement/dateAsString.md)  




##### [isComplete](../models_statement/Statement/isComplete.md)() [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



Checks if all neccessary fields of the <a href="../models_statement/Statement-class.md">Statement</a> are filled in.   




##### [noSuchMethod](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)([Invocation](https://api.flutter.dev/flutter/dart-core/Invocation-class.html) invocation) dynamic



Invoked when a non-existent method or property is accessed. [...](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)  
_inherited_



##### [toMap](../models_statement/Statement/toMap.md)() [Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>



Convert a <a href="../models_statement/Statement-class.md">Statement</a> back to its <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> representation.   




##### [toString](https://api.flutter.dev/flutter/dart-core/Object/toString.html)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A string representation of this object. [...](https://api.flutter.dev/flutter/dart-core/Object/toString.html)  
_inherited_




## Operators

##### [operator ==](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)([Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) other) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



The equality operator. [...](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)  
_inherited_











