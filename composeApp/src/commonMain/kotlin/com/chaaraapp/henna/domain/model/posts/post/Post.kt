package com.chaaraapp.henna.domain.model.posts.post

import kotlinx.serialization.Serializable

@Serializable
data class Post(
    val `data`: PostModel,
    val message: String,
    val status: String
)