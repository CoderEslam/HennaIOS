package com.chaaraapp.henna.domain.model.posts.post


import com.chaaraapp.henna.domain.model.auth.login.User
import kotlinx.serialization.Serializable

@Serializable
data class PostModel(
    val comments: List<Comment>? = emptyList(),
    val comments_count: Int? = 0,
    val content: String? = "",
    val description: String? = "",
    val favorites: List<Favorite>? = emptyList(),
    val favorites_count: Int? = 0,
    val id: Int? = 0,
    val likes: List<Like>? = emptyList(),
    val likes_count: Int? = 0,
    val type: String? = "",
    val user: User? = null,
    val user_id: Int? = 0
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as PostModel

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?: 0
    }
}