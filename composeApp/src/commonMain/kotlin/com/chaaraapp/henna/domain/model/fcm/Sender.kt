package com.chaaraapp.henna.domain.model.fcm

import kotlinx.serialization.Serializable

@Serializable
data class Sender(var data: MessageData, var to: String)


