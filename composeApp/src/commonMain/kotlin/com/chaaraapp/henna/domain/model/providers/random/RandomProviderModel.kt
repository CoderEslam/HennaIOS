package com.chaaraapp.henna.domain.model.providers.random
import com.chaaraapp.henna.domain.model.auth.login.User
import com.chaaraapp.henna.domain.model.providers.provider.ProviderModel
import com.chaaraapp.henna.domain.model.services.service.ServiceModel
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class RandomProviderModel(
    @SerialName("brand_name")
    val brandName: String = "",
    @SerialName("id")
    val id: Int = 0,
    @SerialName("provider_bio")
    val providerBio: String = "",
    @SerialName("services")
    val services: List<ServiceModel>? = listOf(),
    @SerialName("user")
    val user: User? = User(),
    @SerialName("user_id")
    val userId: Int? = 0
) {
    fun fromRandomProviderModelToProviderModel(): ProviderModel {
        return ProviderModel(
            brand_name = this.brandName,
            id = this.id,
            provider_bio = this.providerBio,
            services_count = this.services?.size,
            user = this.user,
            user_id = this.userId
        )
    }
}