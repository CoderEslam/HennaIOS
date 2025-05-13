package com.chaaraapp.henna.domain.model.report

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class SendReport(
    @SerialName("email")
    val email: String,
    @SerialName("content_type")
    val contentType: String,
    @SerialName("content_id")
    val contentId: String,
)
