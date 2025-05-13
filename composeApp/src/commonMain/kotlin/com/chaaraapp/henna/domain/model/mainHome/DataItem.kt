package com.chaaraapp.henna.domain.model.mainHome

import com.chaaraapp.henna.domain.model.mainHome.DataItemType.Companion.PROVIDERS
import com.chaaraapp.henna.domain.model.mainHome.DataItemType.Companion.SERCICE
import com.chaaraapp.henna.domain.model.providers.provider.ProviderModel
import com.chaaraapp.henna.domain.model.services.service.ServiceModel
import com.chaaraapp.henna.domain.ts.Favorites
import com.chaaraapp.henna.domain.ts.Providers
import com.chaaraapp.henna.domain.ts.Services

private const val TAG = "DataItem"

data class DataItem(val viewType: Int) {

    var serviceModelList: List<ServiceModel>? = null
    var providersList: List<ProviderModel>? = null
    var favorite: Favorites? = null
    var providers: Providers? = null
    var sevices: Services? = null

    constructor(
        viewType: Int = SERCICE,
        serviceModelList: List<ServiceModel>,
        favorite: Favorites,
        sevices: Services
    ) : this(viewType) {
        this.serviceModelList = serviceModelList
        this.favorite = favorite
        this.sevices = sevices
    }

    constructor(
        providersList: List<ProviderModel>?,
        viewType: Int = PROVIDERS,
        providers: Providers
    ) : this(viewType) {
        this.providersList = providersList
        this.providers = providers
    }

    override fun toString(): String {
        return "DataItem(viewType=$viewType, serviceModelList=$serviceModelList, providersList=$, favorite=$favorite)"
    }

}