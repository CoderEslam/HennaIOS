package com.chaaraapp.henna.domain.model.services.service


import kotlinx.serialization.Serializable

@Serializable
data class ServiceList(
    val `data`: List<ServiceModel>
)

@Serializable
data class ServiceModelData(
    val `data`: ServiceModel,
    val message: String = "",
    val status: String = ""
)