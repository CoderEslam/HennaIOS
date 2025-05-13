package com.chaaraapp.henna.domain.model.user

import com.chaaraapp.henna.domain.model.auth.login.User
import kotlinx.serialization.Serializable

@Serializable
data class UserModel(
    val `data`: User? = null
)