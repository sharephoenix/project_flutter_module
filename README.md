# Fluter 之 module Native 混编开发

## 创建 Android 工程 

1. 创建 android 工程 ```Flutter_Preoject_Module```

## 在 ```Flutter_Preoject_Module``` 目录下创建 ```fluttermodule```
1. 如下命令二选一
2. 关键命令1 ``` flutter create --androidx -t module {modulename}```
3. 关键命令2 ``` flutter create -t module {modulename}```
4. 创建两个 ***flutterModule***; ***my_flutter*** 和 ***flutter_module***

## 集成到 Android 项目中

1. 在 android 工程中添加依赖和其它
```
android {
    compileOptions {
        sourceCompatibility 1.8
        targetCompatibility 1.8
    }
}
```
```
dependencies {
    implementation project(':flutter') 
}
```

2. 在 android 的 AndroidManifest.xml 中注册 activity

```
<activity
            android:name="io.flutter.embedding.android.FlutterActivity"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:theme="@style/AppTheme"
            android:windowSoftInputMode="adjustResize" />
        <activity
```
以下下是我在项目中自定义的 flutter activity 也注册在 AndroidManifest.xml
```
<activity
            android:name=".MainFlutterActivity"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:theme="@style/AppTheme"
            android:windowSoftInputMode="adjustResize" />
```

3. 启动 app, 原生界面跳转到 flutter 界面

```
val intent = Intent()
intent.setClass(this, MainFlutterActivity::class.java)
startActivity(intent)
```

4. 一个简单的启动 原生启动 flutter 模块就做好了......

## 使用 MethodChannel 和原生交互

1. 在 ***MainFlutterActivity*** 中注册引擎

```
class MainFlutterActivity: FlutterActivity(), MethodChannel.MethodCallHandler {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channel = GeneratedPluginRegistrant.registerWith(flutterEngine)
        channel.setMethodCallHandler(this)
    }
}
```
***GeneratedPluginRegistrant***
```
@Keep
public final class GeneratedPluginRegistrant {
  static MethodChannel channel;
  public static MethodChannel registerWith(@NonNull FlutterEngine flutterEngine) {
    channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "com.alex.luan/plugin");
    return channel;
  }
}

```

2. flutter 通过 methodChannel 调用原生方法

```
 Future<Null> _jumpToNative() async {
    String result = await jumpPlugin.invokeMethod('oneAct', {"flutter": "flutter hi $_counter"});

    print(result);
}

Future<Null> _jumpToNativeWithValue() async {

 Map<String, String> map = { "flutter": "这是一条来自flutter的参数" };

 String result = await jumpPlugin.invokeMethod('twoAct', map);

 print(result);
}
```

## 原生指定跳转到 flutter 页面

1. MainActivity 中的关键代码; "route"key, 是 flutter 的关键key;

```
val intent = Intent()
intent.setClass(this, MainFlutterActivity::class.java)
intent.putExtra("route", "demo?{\"id\":112233}")
startActivity(intent)
```

2. 入口 flutter 中的代码; 分析routeName 返回加载不同的 ***Widget***

```
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
      return new MyHomePage();
    case "demo":
      return new MySecondPage();
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
```

3. 加载其它模块的方法需要在 yaml 文件中加如下配置

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_module:
    path: ...../Flutter_Preoject_Module/flutter_module
```