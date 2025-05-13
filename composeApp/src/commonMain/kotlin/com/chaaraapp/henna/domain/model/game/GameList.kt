package com.chaaraapp.henna.domain.model.game

import kotlinx.serialization.Serializable

@Serializable
data class GameList(
    val `data`: List<GameModel>? = emptyList()
)