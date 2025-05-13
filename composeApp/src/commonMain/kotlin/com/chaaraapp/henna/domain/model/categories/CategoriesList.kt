package com.chaaraapp.henna.domain.model.categories

import kotlinx.serialization.Serializable

@Serializable
data class CategoriesList(
    val `data`: List<CategoryModel>? = emptyList()
)