package com.chaaraapp.henna.domain.model.services.review

import kotlinx.serialization.Serializable

@Serializable
data class Service(
    val category_id: Int? = 0,
    val currency_id: Int? = 0,
    val description: String? = "",
    val id: Int? = 0,
    val max_price: Float? = 0f,
    val min_price: Int? = 0,
    val name: String? = "",
    val provider_id: Int? = 0,
    val service_image: String? = "",
)