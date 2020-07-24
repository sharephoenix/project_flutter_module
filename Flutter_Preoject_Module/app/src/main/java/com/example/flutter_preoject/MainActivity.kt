package com.example.flutter_preoject

import android.app.Activity
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterActivityLaunchConfigs
import kotlinx.android.synthetic.main.activity_main.*


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        createAction()
    }

    fun createAction() {
        click_btn.setOnClickListener {
            Log.e("Clicked", "this is my clicked!!!!")
//            val intent = MainFlutterActivity.createDefaultIntent(this)
            val intent = Intent()
            intent.setClass(this, MainFlutterActivity::class.java)
            intent.putExtra("route", "/second")
            startActivity(intent)
        }

//        GeneratedPluginRegistrant.registerWith(FlutterEngine(this, null))
    }
}

class MyFlutterActivity: AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        click_btn.setText("fffff")
        click_btn.setOnClickListener {
            getFirstActivity()
        }
    }

    private fun getFirstActivity(): AppCompatActivity? {

        val manager: ActivityManager =
            getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val list = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            manager.appTasks[0].moveToFront()
        } else {
            TODO("VERSION.SDK_INT < LOLLIPOP")
        }
//        val info: ActivityManager.RunningTaskInfo = manager.getRunningTasks(1).get(0)
//
//        val packageName: String = info.topActivity!!.getPackageName()
//        val topclassName: String = info.topActivity!!.getClassName()
//        val baseclassname: String = info.baseActivity!!.getClassName()
//        val acitivitynum: Int = info.numActivities
//        Log.e("activity", manager.deviceConfigurationInfo.toString())
//        (info.topActivity as Activity).finish()
        return null
    }
}