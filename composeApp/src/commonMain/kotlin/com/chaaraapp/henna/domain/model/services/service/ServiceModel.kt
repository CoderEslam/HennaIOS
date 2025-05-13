package com.chaaraapp.henna.domain.model.services.service


import com.chaaraapp.henna.domain.model.currencies.CurrencyModel
import kotlinx.serialization.Serializable

@Serializable
data class ServiceModel(
    val category: Category? = null,
    val category_id: Int? = 0,
    val currency: CurrencyModel? = null,
    val currency_id: Int? = 0,
    val description: String? = "",
    val favorites: List<Favorite>? = emptyList(),
    val favorites_count: Int? = 0,
    val id: Int? = 0,
    val max_price: Float? = 0f,
    val min_price: Int? = 0,
    val name: String? = "",
    val provider: Provider? = null,
    val provider_id: Int? = 0,
    val reviews: List<Review>? = emptyList(),
    val reviews_count: Int? = 0,
    val service_image: String? = "",
) {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (other == null || this::class != other::class) return false

        other as ServiceModel

        return id == other.id
    }

    override fun hashCode(): Int {
        return id ?: 0
    }


}

fun List<Favorite>.isFavorite(user_id: Int): Boolean {
    return this.contains(
        Favorite(
            -1,
            -1,
            user_id,
            null
        )
    )
}

fun List<Review>?.totalRate(reviews_count: Int): Int {
    var r = 0
    this?.let {
        it.forEach { i ->
            r += (i.rate ?: 0)
        }
        r /= reviews_count
    }
    return r
}