package com.chaaraapp.henna.domain.model.posts.post

import kotlinx.serialization.Serializable

@Serializable
data class PostsList(
    val `data`: List<PostModel>? = emptyList(),
    val status: String? = ""
)