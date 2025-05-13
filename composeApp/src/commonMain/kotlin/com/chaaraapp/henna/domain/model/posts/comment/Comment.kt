package com.chaaraapp.henna.domain.model.posts.comment

import kotlinx.serialization.Serializable

@Serializable
data class Comment(
    val post_id: Int,
    val content: String
)