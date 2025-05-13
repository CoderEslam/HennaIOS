package com.chaaraapp.henna.domain.model.user

import kotlinx.serialization.Serializable

@Serializable
data class UpdateProvider(
    val brand_name: String,
    val provider_bio: String,
    val registration_number: String
) {
    override fun toString(): String {
        return "UpdateProvider(brand_name='$brand_name', provider_bio='$provider_bio', registration_number='$registration_number')"
    }
}