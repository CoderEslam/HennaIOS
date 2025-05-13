package com.chaaraapp.henna.domain.model.auth.forgetPassword

import kotlinx.serialization.Serializable

@Serializable
data class Email(
    val email: String = "",
    val password: String = ""
)
