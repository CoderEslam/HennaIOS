package com.chaaraapp.henna.domain.ts

import com.chaaraapp.henna.domain.model.services.service.Review
import kotlinx.coroutines.Job


interface OptionReview {

    fun delete(review: Review): Job

}