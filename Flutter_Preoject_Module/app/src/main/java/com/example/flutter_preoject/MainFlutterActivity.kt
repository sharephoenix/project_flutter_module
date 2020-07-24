package com.example.flutter_preoject

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant


class MainFlutterActivity: FlutterActivity(), MethodChannel.MethodCallHandler {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val channel = GeneratedPluginRegistrant.registerWith(flutterEngine)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        //通过MethodCall可以获取参数和方法名，然后再寻找对应的平台业务，本案例做了2个跳转的业务

        //接收来自flutter的指令oneAct
        //通过MethodCall可以获取参数和方法名，然后再寻找对应的平台业务，本案例做了2个跳转的业务

        //接收来自flutter的指令oneAct
        if (call.method.equals("oneAct")) {

            //跳转到指定Activity
            val intent = Intent(activity, MainActivity::class.java)
            activity.startActivity(intent)

            //返回给flutter的参数
            result.success("success")
        } else if (call.method.equals("twoAct")) {

            //解析参数
            val text: String = call.argument<String>("flutter").toString()
            Log.e("FlutterCallback", text)
            //带参数跳转到指定Activity
            val intent = Intent(activity, MainActivity::class.java)
            activity.startActivity(intent)

            //返回给flutter的参数
            result.success("success")
        } else {
            result.notImplemented()
        }
    }
}