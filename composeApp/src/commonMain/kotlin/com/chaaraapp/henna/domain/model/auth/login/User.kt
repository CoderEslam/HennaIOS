package com.chaaraapp.henna.domain.model.auth.login

import com.chaaraapp.henna.domain.model.countries.CityModel
import com.chaaraapp.henna.domain.model.countries.CountryModel
import com.chaaraapp.henna.domain.model.countries.ProvincesModel
import com.chaaraapp.henna.domain.model.interests.InterestsModel
import com.chaaraapp.henna.domain.model.languages.LanguagesModel
import kotlinx.serialization.Serializable

@Serializable
data class User(
    val background_image: String? = "",
    val city: CityModel? = CityModel(),
    val city_id: Int? = -1,
    val country: CountryModel? = CountryModel(),
    val country_id: Int? = 0,
    val device_token: String? = "",
    val email: String? = "",
    val first_name: String? = "",
    val id: Int = -1,
    val interests: List<InterestsModel>? = emptyList(),
    val language: LanguagesModel? = LanguagesModel(),
    val language_id: Int? = -1,
    val last_name: String? = "",
    val phone: String? = "",
    val phone_extension: String? = "",
    val province: ProvincesModel? = ProvincesModel(),
    val province_id: Int? = -1,
    val user_image: String? = "",
    val provider: Provider? = Provider()
)

