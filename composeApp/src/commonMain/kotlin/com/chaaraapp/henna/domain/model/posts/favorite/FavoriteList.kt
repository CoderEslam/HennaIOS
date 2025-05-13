package com.chaaraapp.henna.domain.model.posts.favorite


import kotlinx.serialization.Serializable

@Serializable
data class FavoriteList(
    val `data`: List<FavoriteModel>
)