package com.chaaraapp.henna.domain.model.notification

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class UpdateFcmToken(
    @SerialName("fcm_token")
    val fcmToken: String
)