package com.chaaraapp.henna.domain.model.services.favorite.favoriteService

import kotlinx.serialization.Serializable

@Serializable
data class FavoriteServiceList(
    val `data`: List<FavoriteServiceModel>? = emptyList()
)