package com.chaaraapp.henna.domain.model.contacts

import kotlinx.serialization.Serializable

@Serializable
data class Contacts(
    val name:String,
    val phone:String,
    val message:String,
)
