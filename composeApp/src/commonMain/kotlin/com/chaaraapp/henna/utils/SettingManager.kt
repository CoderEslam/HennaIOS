package com.chaaraapp.henna.utils

import com.chaaraapp.henna.core.extensions.fromJson
import com.chaaraapp.henna.core.extensions.fromJson2
import com.chaaraapp.henna.core.extensions.toJson
import com.chaaraapp.henna.domain.model.auth.login.User
import com.russhwolf.settings.Settings
import com.russhwolf.settings.get
import com.russhwolf.settings.minusAssign
import com.russhwolf.settings.set
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.IO
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn
import org.jetbrains.compose.resources.getString


class SettingsManager(private val settings: Settings) {


    fun saveString(key: String, value: String) {
        settings[key] = value
    }

    fun getString(key: String, defaultValue: String = ""): String {
        return settings[key] ?: defaultValue
    }


    fun saveUser(user: User) {
        saveObject(user, Constants.USER_OBJECT)
    }


    fun getUser(): User {
        return getObject(Constants.USER_OBJECT, defaultValue = User()) ?: User()
    }


    fun saveInt(key: String, value: Int) {
        settings[key] = value
    }

    fun getInt(key: String, defaultValue: Int = 0): Int {
        return settings[key] ?: defaultValue
    }

    fun getStringFlow(key: String, defaultValue: String = "") = flow {
        emit(settings[key] ?: defaultValue)
    }.flowOn(Dispatchers.IO)


    fun saveBoolean(key: String, value: Boolean) {
        settings[key] = value
    }

    fun getBoolean(key: String, defaultValue: Boolean = false): Boolean {
        return settings[key] ?: defaultValue
    }

    fun remove(key: String) {
        settings -= key
    }

    fun clear() {
        settings.clear()
    }

    private inline fun <reified T> saveObject(value: T?, key: String) {
        value?.let {
            settings[key] = it.toJson()
        }
    }

    private inline fun <reified T> getObject(key: String, defaultValue: T? = null): T? {
        val result = (settings[key] ?: "").fromJson<T>()
        return result ?: defaultValue
    }

    //block providers
    fun getProvidersBlockIds(): List<Int> {
        return try {
            getString(Constants.PROVIDERS_BLOCK_IDS)
                .fromJson2<List<Int>>()
                ?: emptyList()
        } catch (e: Exception) {
            Log.e(TAG, e.message)
            emptyList()
        }
    }
//    fun getProvidersBlockIds(): List<Int> {
//        val ids =
//            getString(Constants.PROVIDERS_BLOCK_IDS).split(",").toString().fromJson<List<Int>>()
//                ?: listOf(-1)
//        return listOf(1) //getString(Constants.PROVIDERS_BLOCK_IDS).fromJson<List<Int>>() ?: listOf(-1)
//    }

    fun setProvidersBlockIds(id: Int) {
        val ids =
            getString(Constants.PROVIDERS_BLOCK_IDS).split(",").toString().fromJson<List<Int>>()
                ?: listOf(-1)
        ids.toMutableList().add(id)
        saveString(Constants.PROVIDERS_BLOCK_IDS, ids.toJson())
    }

    companion object {
        private const val TAG = "SettingManager"
    }
}