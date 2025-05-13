package com.chaaraapp.henna.domain.model.countries


import kotlinx.serialization.Serializable

@Serializable
data class CityModel(
    val id: Int? = -1,
    val name: String? = "",
    val province_id: Int? = -1
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as CityModel

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?: 0
    }

}