package com.chaaraapp.henna.domain.model.interests

import com.chaaraapp.henna.domain.model.categories.CategoryModel
import kotlinx.serialization.Serializable

@Serializable
data class InterestsModel(
    val category: CategoryModel? = CategoryModel(),
    val category_id: Int? = null,
    val id: Int? = null,
    val user_id: Int? = null
)
