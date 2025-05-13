package com.chaaraapp.henna.domain.model.posts.post

import com.chaaraapp.henna.domain.model.auth.login.User
import kotlinx.serialization.Serializable

@Serializable
data class Comment(
    val content: String? = "",
    val id: Int? = 0,
    val post_id: Int? = 0,
    val user_id: Int? = 0,
    val user: User? = null
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as Comment

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?: 0
    }
}