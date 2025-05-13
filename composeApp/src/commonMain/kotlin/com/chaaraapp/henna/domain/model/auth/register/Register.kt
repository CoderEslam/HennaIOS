package com.chaaraapp.henna.domain.model.auth.register

import kotlinx.serialization.Serializable

@Serializable
data class Register(
    val first_name: String,
    val last_name: String,
    val password: String,
    val password_confirmation: String,
    val email: String,
    val phone: String,
    val phone_extension: String
)
