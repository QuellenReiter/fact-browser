


# MainAppBar class






    *[<Null safety>](https://dart.dev/null-safety)*



<p>The AppBar (top of the App) that contains searchbar and links to impressum, datenschutz and
login/logout.
TODO: Remove large if statement and do condition: popupmenu or row.</p>


**Inheritance**

- [Object](https://api.flutter.dev/flutter/dart-core/Object-class.html)
- [DiagnosticableTree](https://api.flutter.dev/flutter/foundation/DiagnosticableTree-class.html)
- [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html)
- [StatefulWidget](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- MainAppBar


**Mixed in types**

- [PreferredSizeWidget](https://api.flutter.dev/flutter/widgets/PreferredSizeWidget-class.html)




## Constructors

[MainAppBar](../widgets_main_app_bar/MainAppBar/MainAppBar.md) ({[Key](https://api.flutter.dev/flutter/foundation/Key-class.html)? key, required [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title, required [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) onLogin, required [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) loggedIn, [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)? searchController})

    


## Properties

##### [barHeight](../widgets_main_app_bar/MainAppBar/barHeight.md) &#8596; [double](https://api.flutter.dev/flutter/dart-core/double-class.html)



The height of the appBar.   
_read / write_



##### [hashCode](https://api.flutter.dev/flutter/widgets/Widget/hashCode.html) &#8594; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The hash code for this object. [...](https://api.flutter.dev/flutter/widgets/Widget/hashCode.html)  
_@[nonVirtual](https://pub.dev/documentation/meta/1.7.0/meta/nonVirtual-constant.html), read-only, inherited_



##### [key](https://api.flutter.dev/flutter/widgets/Widget/key.html) &#8594; [Key](https://api.flutter.dev/flutter/foundation/Key-class.html)?



Controls how one widget replaces another widget in the tree. [...](https://api.flutter.dev/flutter/widgets/Widget/key.html)  
_final, inherited_



##### [loggedIn](../widgets_main_app_bar/MainAppBar/loggedIn.md) &#8594; [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



Stores if user is logged in.   
_final_



##### [onLogin](../widgets_main_app_bar/MainAppBar/onLogin.md) &#8594; [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html)



Callback, if user requests login.   
_final_



##### [preferredSize](../widgets_main_app_bar/MainAppBar/preferredSize.md) &#8594; [Size](https://api.flutter.dev/flutter/dart-ui/Size-class.html)



The size of the appbar.   
_read-only, override_



##### [runtimeType](https://api.flutter.dev/flutter/dart-core/Object/runtimeType.html) &#8594; [Type](https://api.flutter.dev/flutter/dart-core/Type-class.html)



A representation of the runtime type of the object.   
_read-only, inherited_



##### [searchController](../widgets_main_app_bar/MainAppBar/searchController.md) &#8594; [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)?



The controller of the searchbar content and input.   
_final_



##### [title](../widgets_main_app_bar/MainAppBar/title.md) &#8594; [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Page title, currently not displayed.   
_final_




## Methods

##### [createElement](https://api.flutter.dev/flutter/widgets/StatefulWidget/createElement.html)() [StatefulElement](https://api.flutter.dev/flutter/widgets/StatefulElement-class.html)



Creates a <a href="https://api.flutter.dev/flutter/widgets/StatefulElement-class.html">StatefulElement</a> to manage this widget's location in the tree. [...](https://api.flutter.dev/flutter/widgets/StatefulWidget/createElement.html)  
_inherited_



##### [createState](../widgets_main_app_bar/MainAppBar/createState.md)() [State](https://api.flutter.dev/flutter/widgets/State-class.html)&lt;[MainAppBar](../widgets_main_app_bar/MainAppBar-class.md)>



Creates the mutable state for this widget at a given location in the tree. [...](../widgets_main_app_bar/MainAppBar/createState.md)  
_override_



##### [debugDescribeChildren](https://api.flutter.dev/flutter/foundation/DiagnosticableTree/debugDescribeChildren.html)() [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[DiagnosticsNode](https://api.flutter.dev/flutter/foundation/DiagnosticsNode-class.html)>



Returns a list of <code>DiagnosticsNode</code> objects describing this node's
children. [...](https://api.flutter.dev/flutter/foundation/DiagnosticableTree/debugDescribeChildren.html)  
_@[protected](https://pub.dev/documentation/meta/1.7.0/meta/protected-constant.html), inherited_



##### [debugFillProperties](https://api.flutter.dev/flutter/widgets/Widget/debugFillProperties.html)([DiagnosticPropertiesBuilder](https://api.flutter.dev/flutter/foundation/DiagnosticPropertiesBuilder-class.html) properties) void



Add additional properties associated with the node. [...](https://api.flutter.dev/flutter/widgets/Widget/debugFillProperties.html)  
_inherited_



##### [noSuchMethod](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)([Invocation](https://api.flutter.dev/flutter/dart-core/Invocation-class.html) invocation) dynamic



Invoked when a non-existent method or property is accessed. [...](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)  
_inherited_



##### [toDiagnosticsNode](https://api.flutter.dev/flutter/foundation/DiagnosticableTree/toDiagnosticsNode.html)({[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? name, [DiagnosticsTreeStyle](https://api.flutter.dev/flutter/foundation/DiagnosticsTreeStyle.html)? style}) [DiagnosticsNode](https://api.flutter.dev/flutter/foundation/DiagnosticsNode-class.html)



Returns a debug representation of the object that is used by debugging
tools and by <a href="https://api.flutter.dev/flutter/foundation/DiagnosticsNode/toStringDeep.html">DiagnosticsNode.toStringDeep</a>. [...](https://api.flutter.dev/flutter/foundation/DiagnosticableTree/toDiagnosticsNode.html)  
_inherited_



##### [toString](https://api.flutter.dev/flutter/foundation/Diagnosticable/toString.html)({[DiagnosticLevel](https://api.flutter.dev/flutter/foundation/DiagnosticLevel.html) minLevel = DiagnosticLevel.info}) [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A string representation of this object. [...](https://api.flutter.dev/flutter/foundation/Diagnosticable/toString.html)  
_inherited_



##### [toStringDeep](https://api.flutter.dev/flutter/foundation/DiagnosticableTree/toStringDeep.html)({[String](https://api.flutter.dev/flutter/dart-core/String-class.html) prefixLineOne = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? prefixOtherLines, [DiagnosticLevel](https://api.flutter.dev/flutter/foundation/DiagnosticLevel.html) minLevel = DiagnosticLevel.debug}) [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Returns a string representation of this node and its descendants. [...](https://api.flutter.dev/flutter/foundation/DiagnosticableTree/toStringDeep.html)  
_inherited_



##### [toStringShallow](https://api.flutter.dev/flutter/foundation/DiagnosticableTree/toStringShallow.html)({[String](https://api.flutter.dev/flutter/dart-core/String-class.html) joiner = ', ', [DiagnosticLevel](https://api.flutter.dev/flutter/foundation/DiagnosticLevel.html) minLevel = DiagnosticLevel.debug}) [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



Returns a one-line detailed description of the object. [...](https://api.flutter.dev/flutter/foundation/DiagnosticableTree/toStringShallow.html)  
_inherited_



##### [toStringShort](https://api.flutter.dev/flutter/widgets/Widget/toStringShort.html)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A short, textual description of this widget.   
_inherited_




## Operators

##### [operator ==](https://api.flutter.dev/flutter/widgets/Widget/operator_equals.html)([Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) other) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



The equality operator. [...](https://api.flutter.dev/flutter/widgets/Widget/operator_equals.html)  
_@[nonVirtual](https://pub.dev/documentation/meta/1.7.0/meta/nonVirtual-constant.html), inherited_











