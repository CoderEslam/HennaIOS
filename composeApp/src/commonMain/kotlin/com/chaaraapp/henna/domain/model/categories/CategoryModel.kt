package com.chaaraapp.henna.domain.model.categories


import kotlinx.serialization.Serializable

@Serializable
data class CategoryModel(
    val category_image: String? = "",
    val id: Int? = 0,
    val name: String? = "",
    val services: List<Service>? = emptyList(),
    val services_count: Int? = 0,
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as CategoryModel

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?: 0
    }
}