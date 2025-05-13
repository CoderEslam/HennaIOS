package com.chaaraapp.henna.domain.model.languages


import kotlinx.serialization.Serializable

@Serializable
data class LanguagesList(
    val `data`: List<LanguagesModel>? = emptyList()
)