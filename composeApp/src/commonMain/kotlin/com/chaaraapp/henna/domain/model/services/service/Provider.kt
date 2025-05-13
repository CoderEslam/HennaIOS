package com.chaaraapp.henna.domain.model.services.service

import com.chaaraapp.henna.domain.model.auth.login.User
import kotlinx.serialization.Serializable

@Serializable
data class Provider(
    val brand_name: String? = "",
    val id: Int? = 0,
    val provider_bio: String? = "",
    val user_id: Int? = 0,
    val user: User? = null
)