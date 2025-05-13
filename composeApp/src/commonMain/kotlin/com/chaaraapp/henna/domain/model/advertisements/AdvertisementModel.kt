package com.chaaraapp.henna.domain.model.advertisements

import com.chaaraapp.henna.domain.model.auth.login.User
import kotlinx.serialization.Serializable

@Serializable
data class AdvertisementModel(
    val advertisement_content: String,
    val advertisement_type: Int,
    val description: String,
    val id: Int,
    val link: String,
    val rank: Int,
    val user: User,
    val user_id: Int
)