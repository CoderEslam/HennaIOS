package com.chaaraapp.henna.domain.model.chat

import kotlinx.serialization.Serializable

@Serializable
data class Message(
    val text: String,
    val to: Int,
    val from: Int,
    val type: Int,
    val id: String
)  {
    constructor() : this("", -1, -1, -1, "")

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as Message

        return id == other.id
    }

    override fun hashCode(): Int {
        return id.hashCode()
    }
}


