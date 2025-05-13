package com.chaaraapp.henna.domain.model.home

import kotlinx.serialization.Serializable

@Serializable
data class HomeCallback(
    val `data`: List<SearchHomeModel>? = emptyList()
)