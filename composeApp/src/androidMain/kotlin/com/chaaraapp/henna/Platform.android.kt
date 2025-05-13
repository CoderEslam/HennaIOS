package com.chaaraapp.henna

import android.content.Context
import android.os.Build
import com.chaaraapp.henna.app.BaseApp
import com.russhwolf.settings.Settings
import com.russhwolf.settings.SharedPreferencesSettings
import java.util.Timer
import java.util.TimerTask

class AndroidPlatform : Platform {
    override val name: String = "Android ${Build.VERSION.SDK_INT}"
}

actual fun getPlatform(): Platform = AndroidPlatform()

actual fun getSettings(): Settings {
    val sharedPreferences = BaseApp.applicationContext().getSharedPreferences("app-setting", Context.MODE_PRIVATE)
    return SharedPreferencesSettings(sharedPreferences)
}

actual fun startPeriodicApiCallWithTimer(intervalMillis: Long, apiCall: () -> Unit) {
    val timer = Timer()
    timer.schedule(object : TimerTask() {
        override fun run() {
            try {
                apiCall()
            } catch (e: Exception) {
                println("API call failed: ${e.message}")
            }
        }
    }, 0, intervalMillis)
}