package com.chaaraapp.henna.domain.model.auth.forgetPassword

import kotlinx.serialization.Serializable

@Serializable
data class OTP(val otp_code: String)
