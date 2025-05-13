package com.chaaraapp.henna.domain.model.providers.show

import com.chaaraapp.henna.domain.model.auth.login.User
import com.chaaraapp.henna.domain.model.services.service.ServiceModel
import kotlinx.serialization.Serializable

@Serializable
data class ProviderModel(
    val brand_name: String? = "",
    val id: Int? = 0,
    val provider_bio: String? = "",
    val services: List<ServiceModel>? = emptyList(),
    val user: User? = null,
    val user_id: Int = 0
)