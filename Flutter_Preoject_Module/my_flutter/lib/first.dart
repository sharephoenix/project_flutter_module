import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyFirstPage extends StatefulWidget {
  MyFirstPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyFirstPage> {

  void _incrementCounter() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Center(
        child: Column(

        ),
      ),
    );
  }
}
