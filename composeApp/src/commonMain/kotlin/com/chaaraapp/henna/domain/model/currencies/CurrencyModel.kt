package com.chaaraapp.henna.domain.model.currencies

import kotlinx.serialization.Serializable

@Serializable
data class CurrencyModel(
    val id: Int? = -1,
    val name: String? = "",
    val user_id: Int? = -1
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as CurrencyModel

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?:-1
    }

}