package com.chaaraapp.henna.domain.model.services.review


import com.chaaraapp.henna.domain.model.services.service.Review
import kotlinx.serialization.Serializable

@Serializable
data class ReviewsList(
    val `data`: List<Review>
)