


# Queries class






    *[<Null safety>](https://dart.dev/null-safety)*



<p>Class containg various utilities for the database connection.</p>



## Constructors

[Queries](../provider_queries/Queries/Queries.md) ()

    


## Properties

##### [hashCode](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html) &#8594; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The hash code for this object. [...](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html)  
_read-only, inherited_



##### [runtimeType](https://api.flutter.dev/flutter/dart-core/Object/runtimeType.html) &#8594; [Type](https://api.flutter.dev/flutter/dart-core/Type-class.html)



A representation of the runtime type of the object.   
_read-only, inherited_




## Methods

##### [noSuchMethod](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)([Invocation](https://api.flutter.dev/flutter/dart-core/Invocation-class.html) invocation) dynamic



Invoked when a non-existent method or property is accessed. [...](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)  
_inherited_



##### [toString](https://api.flutter.dev/flutter/dart-core/Object/toString.html)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A string representation of this object. [...](https://api.flutter.dev/flutter/dart-core/Object/toString.html)  
_inherited_




## Operators

##### [operator ==](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)([Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) other) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



The equality operator. [...](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)  
_inherited_





## Static Methods

##### [createStatement](../provider_queries/Queries/createStatement.md)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Returns the graphQL mutation to create a <a href="../models_statement/Statement-class.md">Statement</a>.   




##### [deleteFact](../provider_queries/Queries/deleteFact.md)([String](https://api.flutter.dev/flutter/dart-core/String-class.html) factId) [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Returns the graphQL mutation to delete a <a href="../models_fact/Fact-class.md">Fact</a> by <a href="../models_fact/Fact/objectId.md">Fact.objectId</a>.   




##### [getCurrentUser](../provider_queries/Queries/getCurrentUser.md)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Returns the graphQL query to check the current user.   




##### [getStatement](../provider_queries/Queries/getStatement.md)([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? statementID) [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Returns the graphQL query to get a <a href="../models_statement/Statement-class.md">Statement</a> by <a href="../models_statement/Statement/objectId.md">Statement.objectId</a>.   




##### [login](../provider_queries/Queries/login.md)([String](https://api.flutter.dev/flutter/dart-core/String-class.html) username, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) password) [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Returns the graphQL mutation to login.   




##### [searchStatements](../provider_queries/Queries/searchStatements.md)([String](https://api.flutter.dev/flutter/dart-core/String-class.html) query) [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Returns the graphQL query to search for <a href="../models_statement/Statements-class.md">Statements</a>.   




##### [updateStatement](../provider_queries/Queries/updateStatement.md)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Returns the graphQL mutation to update a <a href="../models_statement/Statement-class.md">Statement</a>.   










