package com.chaaraapp.henna.domain.model.posts.post

import kotlinx.serialization.Serializable

@Serializable
data class Favorite(
    val id: Int? = 0,
    val post_id: Int? = 0,
    val user_id: Int? = 0
)