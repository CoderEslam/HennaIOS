package com.chaaraapp.henna.domain.model.providers.random

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class RandomProvider(
    @SerialName("data")
    val `data`: List<RandomProviderModel> = listOf(),
    @SerialName("status")
    val status: String = ""
)