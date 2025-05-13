package com.chaaraapp.henna.domain.model.auth.login

import kotlinx.serialization.Serializable

@Serializable
data class LoginModel(
    val email: String,
    val password: String
)
