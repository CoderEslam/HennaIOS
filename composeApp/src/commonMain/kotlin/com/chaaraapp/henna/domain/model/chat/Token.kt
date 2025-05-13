package com.chaaraapp.henna.domain.model.chat

import kotlinx.serialization.Serializable

@Serializable
data class Token(val token: String) {
    constructor() : this("")
}
