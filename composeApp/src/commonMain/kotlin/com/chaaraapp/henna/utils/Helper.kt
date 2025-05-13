package com.chaaraapp.henna.utils

import com.chaaraapp.henna.core.extensions.isNotNullOrEmptyString


fun imageList(images: String): List<String> {
    return if (images.isNotNullOrEmptyString()) {
        images.split(",")
    } else {
        listOf("")
    }
}