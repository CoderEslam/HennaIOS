package com.chaaraapp.henna

import com.russhwolf.settings.NSUserDefaultsSettings
import com.russhwolf.settings.Settings
import platform.Foundation.NSUserDefaults
import platform.UIKit.UIDevice
import kotlinx.cinterop.*
import platform.darwin.*
import platform.Foundation.*

class IOSPlatform: Platform {
    override val name: String = UIDevice.currentDevice.systemName() + " " + UIDevice.currentDevice.systemVersion
}

actual fun getPlatform(): Platform = IOSPlatform()


actual fun getSettings(): Settings {
    return NSUserDefaultsSettings(NSUserDefaults.standardUserDefaults)
}

@OptIn(ExperimentalForeignApi::class)
actual fun startPeriodicApiCallWithTimer(intervalMillis: Long, apiCall: () -> Unit) {
    val intervalSeconds = intervalMillis.toDouble() / 1000.0
    val timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0u, 0u, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT.toLong(),
        0u
    ))
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, (intervalSeconds.toLong().toULong() * NSEC_PER_SEC), 0u)
    dispatch_source_set_event_handler(timer) {
        apiCall()
    }
    dispatch_resume(timer)
}
