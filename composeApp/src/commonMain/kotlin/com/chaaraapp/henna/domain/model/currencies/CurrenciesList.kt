package com.chaaraapp.henna.domain.model.currencies


import kotlinx.serialization.Serializable

@Serializable
data class CurrenciesList(
    val `data`: List<CurrencyModel>? = emptyList()
)