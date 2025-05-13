package com.chaaraapp.henna.domain.model.home

import kotlinx.serialization.Serializable

@Serializable
data class SearchHome(val name: String? = "") {
    constructor() : this("")
}
