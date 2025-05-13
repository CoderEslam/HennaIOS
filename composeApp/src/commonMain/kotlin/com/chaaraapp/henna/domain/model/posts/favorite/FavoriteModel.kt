package com.chaaraapp.henna.domain.model.posts.favorite


import com.chaaraapp.henna.domain.model.auth.login.User
import kotlinx.serialization.Serializable

@Serializable
data class FavoriteModel(
    val id: Int,
    val post: Post,
    val post_id: Int,
    val user: User,
    val user_id: Int
)