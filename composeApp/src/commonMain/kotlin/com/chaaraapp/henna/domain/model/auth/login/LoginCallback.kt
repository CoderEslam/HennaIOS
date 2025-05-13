package com.chaaraapp.henna.domain.model.auth.login

import kotlinx.serialization.Serializable

@Serializable
data class LoginCallback(
    val role: String? = "",
    val user: User? = null
)