package com.chaaraapp.henna.domain.model

import kotlinx.serialization.Serializable


@Serializable
data class Search(val search_input: String? = "")
