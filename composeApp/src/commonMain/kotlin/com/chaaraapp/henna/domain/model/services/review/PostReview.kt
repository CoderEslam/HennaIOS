package com.chaaraapp.henna.domain.model.services.review

import kotlinx.serialization.Serializable

@Serializable
data class PostReview(
    val service_id: String,
    val rate: Int,
    val description: String
)
