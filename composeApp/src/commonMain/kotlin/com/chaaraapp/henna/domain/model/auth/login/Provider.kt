package com.chaaraapp.henna.domain.model.auth.login

import kotlinx.serialization.Serializable

@Serializable
data class Provider(
    val brand_name: String = "",
    val id: Int = -1,
    val provider_bio: String = "",
    val registration_number: String = "",
    val user_id: Int = -1
)