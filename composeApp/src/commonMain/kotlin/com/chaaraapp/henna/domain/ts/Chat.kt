package com.chaaraapp.henna.domain.ts

import com.chaaraapp.henna.domain.model.chat.ChatList

interface Chat {
    fun goChat(chatList: ChatList)

    fun delete(chatList: ChatList)
}