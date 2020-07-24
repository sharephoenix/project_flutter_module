import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/first.dart';
import 'package:my_flutter/second.dart';
import 'package:flutter_module/main.dart';

void main() => runApp(new MyApp(window.defaultRouteName));

class MyApp extends StatelessWidget {
  final String _routeName;

  MyApp(this._routeName) {
    print("this is default name : $_routeName");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _widgetForRoute(_routeName),
    );
  }
}

Widget _widgetForRoute(String s) {
  print("pageName=" + _getPageName(s) + ",ParamJson=" + _getPageParamJsonStr(s));
  switch (_getPageName(s)) {
    case "demo0":
      return new MySecondPage();
    case "demo":
      return new MyHomePage();
  }
  return MyFirstPage();
}

String _getPageName(String s) {
  if (s.indexOf("?") == -1) {
    return s;
  } else {
    return s.substring(0, s.indexOf("?"));
  }
}

String _getPageParamJsonStr(String s) {
  if (s.indexOf("?") == -1) {
    return "{}";
  } else {
    return s.substring(s.indexOf("?") + 1);
  }
}
