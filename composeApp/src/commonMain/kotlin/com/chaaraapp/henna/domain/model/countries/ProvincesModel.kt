package com.chaaraapp.henna.domain.model.countries

import kotlinx.serialization.Serializable

@Serializable
data class ProvincesModel(
    val cities: List<CityModel>? = emptyList(),
    val country_id: Int? = -1,
    val id: Int? = -1,
    val name: String? = ""
)