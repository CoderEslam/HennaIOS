package com.chaaraapp.henna.domain.model.chat

import kotlinx.serialization.Serializable

@Serializable
data class ChatList(
    val user_id: String? = "",
    val time: Long? = 0L,
    val image: String? = "",
    val name: String? = ""
) {
    constructor() : this("", 0L, "", "")
}
