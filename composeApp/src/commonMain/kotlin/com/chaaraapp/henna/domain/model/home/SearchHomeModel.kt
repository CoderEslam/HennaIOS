package com.chaaraapp.henna.domain.model.home

import kotlinx.serialization.Serializable

@Serializable
data class SearchHomeModel(
    val flag: Int? = -1,
    val id: Int? = -1,
    val first_name: String? = "",
    val last_name: String? = ""
)