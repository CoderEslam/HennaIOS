package com.chaaraapp.henna.domain.model.languages

import kotlinx.serialization.Serializable

@Serializable
data class LanguagesModel(
    val id: Int? = -1,
    val name: String? = "",
    val prefix: String? = "en"
)