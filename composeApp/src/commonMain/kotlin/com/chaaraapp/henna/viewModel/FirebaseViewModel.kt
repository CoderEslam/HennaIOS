package com.chaaraapp.henna.viewModel

import cafe.adriel.voyager.core.model.ScreenModel
import cafe.adriel.voyager.core.model.screenModelScope
import com.mmk.kmpnotifier.notification.NotifierManager
import kotlinx.coroutines.launch

//https://github.com/mirzemehdi/KMPNotifier
class FirebaseNotificationViewModel : ScreenModel {

    fun sendLocalNotification(title: String, body: String) {
        val notifier = NotifierManager.getLocalNotifier()
        val notificationId = notifier.notify("Title", "Body")
        // or you can use below to specify ID yourself
        notifier.notify(notificationId, title, body)
    }

    fun fcmToken(fcmToken: (String?) -> Unit) = screenModelScope.launch {
        fcmToken(NotifierManager.getPushNotifier().getToken())
    }

    fun deleteToken() = screenModelScope.launch {
        NotifierManager.getPushNotifier().deleteMyToken()
    }

    fun removeNotificationById(notificationId: Int) {
        val notifier = NotifierManager.getLocalNotifier()
        notifier.remove(notificationId) //Removes notification by Id
    }

    fun removeAllNotification() {
        val notifier = NotifierManager.getLocalNotifier()
        notifier.removeAll()
    }

}