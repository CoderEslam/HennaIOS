package com.chaaraapp.henna.domain.model.notification

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class SendNotification(
    @SerialName("title")
    val title: String,
    @SerialName("body")
    val body: String,
    @SerialName("user_id")
    val userId: Int
)