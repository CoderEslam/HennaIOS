package com.chaaraapp.henna.domain.model.countries

import kotlinx.serialization.Serializable

@Serializable
data class CountriesList(
    val `data`: List<CountryModel>? = emptyList()
)