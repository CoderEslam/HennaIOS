package com.chaaraapp.henna.utils

object Log {
    fun <T> log(tag: String, data: T) {
        println("$tag , $data")
    }

    fun <T> e(tag: String, data: T) {
        println("ERROR => $tag , $data")
    }

    fun <T> i(tag: String, data: T) {
        println("INFO => $tag , $data")
    }

    fun <T> w(tag: String, data: T) {
        println("Warning => $tag , $data")
    }

    fun <T> d(tag: String, data: T) {
        println("Debug => $tag , $data")
    }
}