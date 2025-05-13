package com.chaaraapp.henna.domain.model.services.service

import com.chaaraapp.henna.domain.model.auth.login.User
import com.chaaraapp.henna.domain.model.services.review.Service
import kotlinx.serialization.Serializable

@Serializable
data class Review(
    val description: String? = "",
    val id: Int? = 0,
    val rate: Int? = 0,
    val service: Service? = null,
    val service_id: Int? = 0,
    val user: User? = null,
    val user_id: Int? = 0
)