package com.chaaraapp.henna.domain.model.fcm

import kotlinx.serialization.Serializable

@Serializable
data class MessageData(
    val user: String,
    val icon: Int,
    val body: String,
    val title: String,
    val sent: String
)