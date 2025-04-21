package com.example.app
import vn.vihat.omicall.omicallsdk.OmicallsdkPlugin
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.WindowInsets
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import com.facebook.FacebookCallback
import com.facebook.FacebookException
import com.facebook.FacebookSdk


class MainActivity: FlutterActivity() {
        override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        //2
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "demo").setMethodCallHandler {
            // 3
            call, result ->
                    when (call.method) {
                "getPackage" -> {
                    val data : String = resources.getString(R.string.secret_key);
                    result.success(data)
                }
                else -> result.notImplemented()
            }
        }
        FacebookSdk.setClientToken("f07925cc66467f7aad2786c52d406346")
        FacebookSdk.setApplicationId("565629662330222")
        FacebookSdk.sdkInitialize(activity)
        FacebookSdk.setAutoLogAppEventsEnabled(true)
        FacebookSdk.setAdvertiserIDCollectionEnabled(false)
    }

//
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        val decorView: View = activity.window.decorView
//        decorView.setOnApplyWindowInsetsListener {v, insets  ->
//
////            Log.d("setOnApplyWindowInsetsListener","  $insets")
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
//                Log.d("setOnApplyWindowInsetsListener","  ${insets.getInsets( WindowInsets.Type.navigationBars())}")
//                Log.d("setOnApplyWindowInsetsListener",
//                        "  ${decorView.rootWindowInsets.toString()}")
//                Log.d("setOnApplyWindowInsetsListener",
//                        "  ${decorView.rootWindowInsets.toString()
//                                .replace("{","\":{\"")
//                                .replace("=","\":\"")
//                                .replace(",","\",\"")
//                                .replace("\"\n    ","\"")
//                                .replace("}","\"},\"")
//                                .replace(" ","")
//                                .replace("null","Insets\":{},\"")
//                                .replace("max\":\"Insets\":{","max_Insets\":{")
//                                .replace("    ","")
//                                .replace("\n","\"},\"")
//                                .replace("\":\"Insets\":","\":{\"Insets\":")
//                                .substringBefore(",\"windowDecor\":")
//                                .substringAfter("WindowInsets\":")
//                                }}")
//            }
//            insets
//        }
//    }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            OmicallsdkPlugin.onOmiIntent(this, intent)
        } catch (e: Throwable) {
            e.printStackTrace()
        }
    }

    override fun onResume(){
        super.onResume()
        OmicallsdkPlugin.onResume(this);
    }

    // thanh.ph omicall
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        OmicallsdkPlugin.onRequestPermissionsResult(requestCode, permissions, grantResults, this)
    }

    override fun onDestroy() {
        super.onDestroy()
        OmicallsdkPlugin.onDestroy()
    }
    // thanh.ph omicall end
}
