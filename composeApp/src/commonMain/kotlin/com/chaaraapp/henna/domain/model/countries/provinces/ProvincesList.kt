package com.chaaraapp.henna.domain.model.countries.provinces

import com.chaaraapp.henna.domain.model.countries.ProvincesModel
import kotlinx.serialization.Serializable

@Serializable
data class ProvincesList(
    val `data`: List<ProvincesModel>? = emptyList()
)