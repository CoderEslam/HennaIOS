package com.chaaraapp.henna.domain.model.plans

import kotlinx.serialization.Serializable

@Serializable
data class PlanModel(
    val created_at: String? = "",
    val description: String? = "",
    val discount: Double? = 0.0,
    val id: Int? = -1,
    val months: Int? = -1,
    val price: Int? = -1,
    val sub_title: String? = "",
    val title: String? = "",
    val updated_at: String? = "",
    val user_id: Int? = -1
)