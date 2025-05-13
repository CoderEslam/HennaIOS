package com.chaaraapp.henna.domain.model.countries

import kotlinx.serialization.Serializable

@Serializable
data class CountryModel(
    val id: Int? = -1,
    val name: String? = "",
    val provinces: List<ProvincesModel>? = emptyList()
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as CountryModel

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?: 0
    }
}