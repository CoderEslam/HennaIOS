package com.chaaraapp.henna.domain.model.game

import kotlinx.serialization.Serializable

@Serializable
data class GameModel(
    val id: Int? = -1,
    val image_1: String? = "",
    val image_2: String? = "",
    val question: String? = "",
    val user_id: Int? = -1
)