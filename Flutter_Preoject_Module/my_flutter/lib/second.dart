import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MySecondPage extends StatefulWidget {
  MySecondPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MySecondPage> {
  //获取到插件与原生的交互通道
  static const jumpPlugin = const MethodChannel('com.alex.luan/plugin');

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _jumpToNative();
  }

  Future<Null> _jumpToNative() async {
    String result = await jumpPlugin.invokeMethod('oneAct', {"flutter": "flutter hi $_counter"});

    print(result);
  }

  Future<Null> _jumpToNativeWithValue() async {

    Map<String, String> map = { "flutter": "这是一条来自flutter的参数" };

    String result = await jumpPlugin.invokeMethod('twoAct', map);

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
