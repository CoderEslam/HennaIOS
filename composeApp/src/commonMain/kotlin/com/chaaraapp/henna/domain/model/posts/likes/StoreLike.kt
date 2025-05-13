package com.chaaraapp.henna.domain.model.posts.likes

import kotlinx.serialization.Serializable

@Serializable
data class StoreLike(
    val post_id: String
)
