package com.chaaraapp.henna.domain.ts

import com.chaaraapp.henna.domain.model.services.service.ServiceModel


interface DeleteService {
    fun onDelete(serviceModel: ServiceModel)
}