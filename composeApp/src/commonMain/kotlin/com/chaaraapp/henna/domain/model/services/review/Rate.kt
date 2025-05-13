package com.chaaraapp.henna.domain.model.services.review

import kotlinx.serialization.Serializable

@Serializable
data class Rate(val name: String, val rate: Int)
