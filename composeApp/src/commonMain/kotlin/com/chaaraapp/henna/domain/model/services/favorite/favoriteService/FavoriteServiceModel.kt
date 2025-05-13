package com.chaaraapp.henna.domain.model.services.favorite.favoriteService

import com.chaaraapp.henna.domain.model.auth.login.User
import kotlinx.serialization.Serializable

@Serializable
data class FavoriteServiceModel(
    val id: Int? = -1,
    val service: Service? = null,
    val service_id: Int? = -1,
    val user: User? = null,
    val user_id: Int? = -1
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as FavoriteServiceModel

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?: -1
    }
}