package com.chaaraapp.henna.domain.model.plans

import kotlinx.serialization.Serializable

@Serializable
data class PlansList(
    val `data`: List<PlanModel>? = emptyList()
)