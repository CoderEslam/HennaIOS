package com.chaaraapp.henna.domain.ts

import com.chaaraapp.henna.domain.model.interests.InterestsModel
import com.chaaraapp.henna.domain.model.interests.list.InterestModel
import kotlinx.coroutines.Job

interface Interests {
    fun storeInterests(interestsModel: InterestModel): Job
    fun deleteInterests(interestsModel: InterestsModel): Job
}