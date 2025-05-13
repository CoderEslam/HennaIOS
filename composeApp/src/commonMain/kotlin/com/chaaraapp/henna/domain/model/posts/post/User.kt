package com.chaaraapp.henna.domain.model.posts.post

import kotlinx.serialization.Serializable

@Serializable
data class User(
    val background_image: String,
    val city_id: Int,
    val country_id: Int,
    val created_at: String,
    val device_token: String,
    val email: String,
    val first_name: String,
    val id: Int,
    val language_id: Int,
    val last_name: String,
    val phone: String,
    val province_id: Int,
    val status: String,
    val updated_at: String,
    val user_image: String
)