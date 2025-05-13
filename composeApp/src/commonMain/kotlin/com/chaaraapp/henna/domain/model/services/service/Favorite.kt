package com.chaaraapp.henna.domain.model.services.service


import com.chaaraapp.henna.domain.model.auth.login.User
import kotlinx.serialization.Serializable

@Serializable
data class Favorite(
    val id: Int? = 0,
    val service_id: Int? = 0,
    val user_id: Int? = 0,
    val user: User? = null
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as Favorite

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?: 0
    }
}