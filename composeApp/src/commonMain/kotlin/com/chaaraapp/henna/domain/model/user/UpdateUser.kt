package com.chaaraapp.henna.domain.model.user

import kotlinx.serialization.Serializable

@Serializable
data class UpdateUser(
    val first_name: String,
    val last_name: String,
    val phone: String,
    val email: String,
    val phone_extension: String,
    val country_id: String,
    val province_id: String,
    val city_id: String,
    val language_id: String,
    val interests: List<Int>? = emptyList(),
    val brand_name: String? = "",
    val provider_bio: String? = "",
    val registration_number: String? = ""
)