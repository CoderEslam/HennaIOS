package com.chaaraapp.henna.domain.ts

import kotlinx.coroutines.Job


interface Favorites {
    fun onDelete(serviceId: Int): Job
    fun onFavorite(serviceId: Int): Job
}