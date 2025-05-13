package com.chaaraapp.henna.domain.model.providers.provider

import kotlinx.serialization.Serializable

@Serializable
data class ProviderList(
    val `data`: List<ProviderModel>
)