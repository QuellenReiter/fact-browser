


# DatabaseUtils class






    *[<Null safety>](https://dart.dev/null-safety)*



<p>This class facilitates the connection to the database and manages its
responses.</p>



## Constructors

[DatabaseUtils](../provider_database_utils/DatabaseUtils/DatabaseUtils.md) ()

    


## Properties

##### [hashCode](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html) &#8594; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The hash code for this object. [...](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html)  
_read-only, inherited_



##### [runtimeType](https://api.flutter.dev/flutter/dart-core/Object/runtimeType.html) &#8594; [Type](https://api.flutter.dev/flutter/dart-core/Type-class.html)



A representation of the runtime type of the object.   
_read-only, inherited_



##### [safeStorage](../provider_database_utils/DatabaseUtils/safeStorage.md) &#8594; [FlutterSecureStorage](https://pub.dev/documentation/flutter_secure_storage/5.0.2/flutter_secure_storage/FlutterSecureStorage-class.html)



Object to access <a href="https://pub.dev/documentation/flutter_secure_storage/5.0.2/flutter_secure_storage/FlutterSecureStorage-class.html">FlutterSecureStorage</a>.   
_final_




## Methods

##### [checkToken](../provider_database_utils/DatabaseUtils/checkToken.md)() [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)>



Checks if token is valid.   




##### [getStatement](../provider_database_utils/DatabaseUtils/getStatement.md)([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? statementID) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[Statement](../models_statement/Statement-class.md)?>



Get a single <code>Statement</code> from the Database by <a href="../models_statement/Statement/objectId.md">Statement.objectId</a>.   




##### [login](../provider_database_utils/DatabaseUtils/login.md)([String](https://api.flutter.dev/flutter/dart-core/String-class.html) username, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) password, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) loginCallback) void



Login a user.   




##### [logout](../provider_database_utils/DatabaseUtils/logout.md)() [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void>



Logsout a user by deleting the session token.   




##### [noSuchMethod](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)([Invocation](https://api.flutter.dev/flutter/dart-core/Invocation-class.html) invocation) dynamic



Invoked when a non-existent method or property is accessed. [...](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)  
_inherited_



##### [sendData](../provider_database_utils/DatabaseUtils/sendData.md)([Statement](../models_statement/Statement-class.md) statement, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) reloadEditScreen) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[QueryResult](https://pub.dev/documentation/graphql/5.0.1/graphql/QueryResult-class.html)?>



Send a newly created <a href="../models_statement/Statement-class.md">Statement</a> to the Database.   




##### [toString](https://api.flutter.dev/flutter/dart-core/Object/toString.html)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A string representation of this object. [...](https://api.flutter.dev/flutter/dart-core/Object/toString.html)  
_inherited_



##### [updateData](../provider_database_utils/DatabaseUtils/updateData.md)([Statement](../models_statement/Statement-class.md) statement, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> oldFactIds, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) reloadEditScreen) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[QueryResult](https://pub.dev/documentation/graphql/5.0.1/graphql/QueryResult-class.html)?>



Update a <a href="../models_statement/Statement-class.md">Statement</a> to from the Database.   





## Operators

##### [operator ==](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)([Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) other) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



The equality operator. [...](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)  
_inherited_











