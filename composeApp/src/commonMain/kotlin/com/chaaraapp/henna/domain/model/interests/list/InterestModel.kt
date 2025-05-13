package com.chaaraapp.henna.domain.model.interests.list


import kotlinx.serialization.Serializable

@Serializable
data class InterestModel(
    val category_image: String? = "",
    val id: Int? = -1,
    val name: String? = "",
    val user_id: Int? = -1
)