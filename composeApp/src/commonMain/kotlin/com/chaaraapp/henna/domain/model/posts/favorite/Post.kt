package com.chaaraapp.henna.domain.model.posts.favorite

import kotlinx.serialization.Serializable

@Serializable
data class Post(
    val content: String,
    val description: String,
    val id: Int,
    val type: String, //belong to category id
    val user_id: Int
)