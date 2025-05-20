package com.chaaraapp.henna.viewModel

import cafe.adriel.voyager.core.model.ScreenModel
import cafe.adriel.voyager.core.model.screenModelScope
import com.chaaraapp.henna.core.extensions.fromJson
import com.chaaraapp.henna.core.extensions.fromJson2
import com.chaaraapp.henna.core.extensions.isNotNullOrEmptyString
import com.chaaraapp.henna.core.extensions.toJson
import com.chaaraapp.henna.domain.model.auth.login.Provider
import com.chaaraapp.henna.domain.model.auth.login.User
import com.chaaraapp.henna.getSettings
import com.chaaraapp.henna.utils.Constants
import com.chaaraapp.henna.utils.Log
import com.chaaraapp.henna.utils.SettingsManager
import kotlinx.coroutines.launch

class UserDataViewModel() : ScreenModel {

    private val settingsManager: SettingsManager = SettingsManager(getSettings())

    fun getToken(token: (value: String) -> Unit) {
        token(settingsManager.getString(Constants.TOKEN))
    }

    fun getUserId(): Int {
        return settingsManager.getUser().id
    }

    fun getUserID(id: (Int) -> Unit) {
        id(settingsManager.getUser().id)
    }

    fun getTokenFlow(token: (value: String) -> Unit) = screenModelScope.launch {
        settingsManager.getStringFlow(Constants.TOKEN).collect {
            token(it)
        }
    }

    fun getUser(user: (value: User) -> Unit) {
        user(settingsManager.getUser())
    }

    fun getUserNormal(): User {
        return settingsManager.getUser()
    }

    fun getAppLang(): String {
        return if (settingsManager.getUser().language?.prefix?.isNotNullOrEmptyString() == true) {
            settingsManager.getUser().language?.prefix ?: "en"
        } else {
            ""
        }
    }

    fun getProviderNormal(): Provider {
        return if (settingsManager.getUser().provider?.id != -1) {
            settingsManager.getUser().provider ?: Provider()
        } else {
            Provider()
        }
    }


    fun getProviderIdNormal(): Int? {
        return settingsManager.getUser().provider?.id
    }

    fun getProviderId(id: (value: Int) -> Unit) {
        id(settingsManager.getUser().provider?.id ?: -1)
    }

    fun getProvider(provider: (value: Provider) -> Unit) {
        provider(settingsManager.getUser().provider ?: Provider())
    }

    //block providers
    fun getProvidersBlockIds(): List<Int> {
        return try {
            settingsManager.getString(Constants.PROVIDERS_BLOCK_IDS)
                .fromJson2<List<Int>>()
                ?: emptyList()
            emptyList()
        } catch (e: Exception) {
            Log.e(TAG, e.message)
            emptyList()
        }
    }

    fun setProvidersBlockIds(id: Int) {
        try {
            val ids = settingsManager.getString(Constants.PROVIDERS_BLOCK_IDS)
                .fromJson2<MutableList<Int>>()
                ?: mutableListOf()
            if (!ids.contains(id)) {
                ids.add(id)
            }
            settingsManager.saveString(Constants.PROVIDERS_BLOCK_IDS, ids.toJson())
        } catch (e: Exception) {
            Log.e(TAG, e.message)
        }
    }

    fun loginAsGuest() {
        settingsManager.saveUser(User())
    }

    fun logout() {
        settingsManager.clear()
    }

    companion object {
        private const val TAG = "UserDataViewModel"
    }
}
