package com.chaaraapp.henna.domain.model.advertisements

import kotlinx.serialization.Serializable

@Serializable
data class AdvertisementList(
    val `data`: List<AdvertisementModel>
)