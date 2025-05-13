package com.chaaraapp.henna.utils

import io.ktor.client.HttpClient
import io.ktor.client.plugins.DefaultRequest
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.logging.LogLevel
import io.ktor.client.plugins.logging.Logger
import io.ktor.client.plugins.logging.Logging
import io.ktor.client.plugins.logging.SIMPLE
import io.ktor.client.plugins.websocket.WebSockets
import io.ktor.client.request.header
import io.ktor.http.ContentType
import io.ktor.http.contentType
import io.ktor.serialization.kotlinx.KotlinxWebsocketSerializationConverter
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json


fun createHttpClient(settingsManager: SettingsManager): HttpClient {
    return HttpClient() {
        install(Logging) {
//            logger = object : Logger {
//                override fun log(message: String) {
//                    println("Ktor Log: $message")
//                }
//            }
            level = LogLevel.ALL // Choose the level of detail (BODY, HEADERS, INFO, ALL)
            logger = Logger.SIMPLE // You can also use Logger.DEFAULT or a custom logger
        }
        install(WebSockets) {
            contentConverter = KotlinxWebsocketSerializationConverter(Json)
        }
        install(ContentNegotiation) {
            json(Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            })
        }
        install(DefaultRequest) {
            header("Authorization", "Bearer ${settingsManager.getString(Constants.TOKEN, "")}")
            contentType(ContentType.Application.Json)
        }
    }
}

fun json(): Json {
    return Json {
        ignoreUnknownKeys = true
        prettyPrint = true
        isLenient = true
    }
}

fun clientWebSocket(): HttpClient {
    return HttpClient() {
        install(Logging) {
            level = LogLevel.ALL // Choose the level of detail (BODY, HEADERS, INFO, ALL)
            logger = Logger.SIMPLE // You can also use Logger.DEFAULT or a custom logger
        }
        install(WebSockets) {
            contentConverter = KotlinxWebsocketSerializationConverter(Json)
        }
        install(ContentNegotiation) {
            json(Json {
                prettyPrint = true
                isLenient = true
                ignoreUnknownKeys = true
            })
        }
    }
}