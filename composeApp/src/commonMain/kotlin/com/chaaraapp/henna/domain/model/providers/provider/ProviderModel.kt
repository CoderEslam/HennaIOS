package com.chaaraapp.henna.domain.model.providers.provider

import com.chaaraapp.henna.domain.model.auth.login.User
import kotlinx.serialization.Serializable

@Serializable
data class ProviderModel(
    val brand_name: String? = "",
    val id: Int? = 0,
    val provider_bio: String? = "",
    val services_count: Int? = 0,
    val user: User? = null,
    val user_id: Int? = 0
)