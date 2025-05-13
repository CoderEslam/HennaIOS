package com.chaaraapp.henna.domain.model.services.favorite.favoriteService

import kotlinx.serialization.Serializable

@Serializable
data class Service(
    val category_id: Int? = -1,
    val currency_id: Int? = -1,
    val description: String? = "",
    val id: Int? = -1,
    val max_price: Float? = -1f,
    val min_price: Int? = -1,
    val name: String? = "",
    val provider_id: Int? = -1,
    val service_image: String? = ""
)