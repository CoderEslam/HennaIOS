package com.chaaraapp.henna

import com.russhwolf.settings.Settings

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform

expect fun getSettings(): Settings

//https://chat.qwen.ai/c/57c3f3b9-4228-4a2b-b2d2-a9b7a7fc49ec
expect fun startPeriodicApiCallWithTimer(intervalMillis: Long, apiCall: () -> Unit)