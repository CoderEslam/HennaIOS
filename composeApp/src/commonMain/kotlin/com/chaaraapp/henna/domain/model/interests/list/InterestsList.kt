package com.chaaraapp.henna.domain.model.interests.list

import kotlinx.serialization.Serializable

@Serializable
data class InterestsList(
    val `data`: List<InterestModel>? = emptyList()
)