package com.chaaraapp.henna.domain.model.services.filter

import com.chaaraapp.henna.domain.model.services.service.ServiceModel
import kotlinx.serialization.Serializable

@Serializable
data class FilterList(
    val `data`: List<ServiceModel>? = emptyList(),
    val status: String? = ""
)