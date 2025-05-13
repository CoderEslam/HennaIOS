package com.chaaraapp.henna.domain.model.services.reviewsOfService

import com.chaaraapp.henna.domain.model.services.service.Review
import kotlinx.serialization.Serializable

@Serializable
data class ReviewsServiceModel(
    val category_id: Int? = 0,
    val currency_id: Int? = 0,
    val description: String? = "",
    val id: Int? = 0,
    val max_price: Float? = 0f,
    val min_price: Int? = 0,
    val name: String? = "",
    val provider_id: Int? = 0,
    val reviews: List<Review>? = emptyList(),
    val service_image: String? = "",
)