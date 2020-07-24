import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/first.dart';
import 'package:my_flutter/second.dart';

void main() => runApp(new MyApp(window.defaultRouteName));

class MyApp extends StatelessWidget {
  final String _routeName;

  MyApp(this._routeName) {
    print("this is default name : $_routeName");
  }

  _clickAction(BuildContext context) {
    Navigator.pushNamed(context, _routeName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/first': (BuildContext context) => new MyFirstPage(),
        '/second': (BuildContext context) => new MySecondPage(),
      },
    );
  }
}
