package com.chaaraapp.henna.domain.model.posts.post

import kotlinx.serialization.Serializable

@Serializable
data class Like(
    val id: Int? = 0,
    val post_id: Int? = 0,
    val user_id: Int? = 0
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as Like

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?: 0
    }
}