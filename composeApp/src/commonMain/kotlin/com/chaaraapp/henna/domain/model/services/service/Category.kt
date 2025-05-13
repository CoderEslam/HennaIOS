package com.chaaraapp.henna.domain.model.services.service


import kotlinx.serialization.Serializable

@Serializable
data class Category(
    val category_image: String? = "",
    val id: Int? = -1,
    val name: String? = "",
    val user_id: Int? = -1
)