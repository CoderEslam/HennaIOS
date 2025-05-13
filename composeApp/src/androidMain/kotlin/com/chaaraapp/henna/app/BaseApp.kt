package com.chaaraapp.henna.app

import android.app.Application
import android.content.Context
import com.chaaraapp.henna.R
import com.mmk.kmpnotifier.notification.NotifierManager
import com.mmk.kmpnotifier.notification.configuration.NotificationPlatformConfiguration


class BaseApp : Application() {

    init {
        instance = this
    }

    override fun onCreate() {
        super.onCreate()
        NotifierManager.initialize(
            configuration = NotificationPlatformConfiguration.Android(
                notificationIconResId = R.drawable.ic_launcher_foreground,
                showPushNotification = true,
            )
        )
        val context: Context = applicationContext()
    }


    companion object {
        private var instance: BaseApp? = null

        fun applicationContext(): Context {
            return instance!!.applicationContext
        }
    }

}