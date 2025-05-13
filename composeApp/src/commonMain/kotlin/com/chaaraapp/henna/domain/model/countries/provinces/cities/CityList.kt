package com.chaaraapp.henna.domain.model.countries.provinces.cities


import com.chaaraapp.henna.domain.model.countries.CityModel
import kotlinx.serialization.Serializable

@Serializable
data class CityList(
    val `data`: List<CityModel>? = emptyList()
)