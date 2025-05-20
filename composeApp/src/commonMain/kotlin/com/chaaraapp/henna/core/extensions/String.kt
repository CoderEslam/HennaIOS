package com.chaaraapp.henna.core.extensions

import com.chaaraapp.henna.utils.Log
import kotlinx.serialization.json.Json
import kotlinx.serialization.serializer

fun String.isNotNullOrEmptyString(): Boolean {
    return !(this.isEmpty() || this.isBlank() || this == "null")
}

inline fun <reified T> T.toJson(): String {
    return Json.encodeToString(serializer<T>(), this)
}


inline fun <reified T> String?.fromJson(): T? {
    return if (this != null) Json.decodeFromString(serializer<T>(), this) else this
}

inline fun <reified T> String?.fromJson2(): T? {
    return if (!this.isNullOrBlank()) {
        try {
            Json.decodeFromString<T>(this)
        } catch (e: Exception) {
            Log.e("JsonParsing", "Failed to parse JSON ${e.message}")
            null
        }
    } else {
        null
    }
}