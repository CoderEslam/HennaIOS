package com.chaaraapp.henna.domain.model.services.filter

import kotlinx.serialization.Serializable

@Serializable
data class FilterService(
    val category_id: List<Int> = emptyList(),
    val city_id: List<Int> = emptyList(),
    val provider: List<Int> = emptyList(),
    val from_price: Int = 1,
    val to_price: Int = 60000,
    val currency_id: List<Int> = emptyList(),
    val search_input: String = ""
)
