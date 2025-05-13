package com.chaaraapp.henna.utils

object Constants {
    //https://motoaxi.onrender.com

    private const val VERSION = "v1"
    private const val API = "api"
    private const val HOST = "backend.hennapp.es"
    const val BASE_URL = "https://$HOST/$API/$VERSION/"
    private const val IMAGE_BASE_URL = "https://$HOST/public/"
    const val CategoryImages = "${IMAGE_BASE_URL}category_images/"
    const val QuestionImages = "${IMAGE_BASE_URL}questions_image/"
    const val ServiceImages = "${IMAGE_BASE_URL}service_images/"
    const val UsersImages = "${IMAGE_BASE_URL}user_images/"
    const val PostContent = "${IMAGE_BASE_URL}post_content/"
    const val BASE_URL_VIDEO = "${IMAGE_BASE_URL}post_content/"
    const val BackgroundImages = "${IMAGE_BASE_URL}background_images/"
    const val AdvertisementImages = "${IMAGE_BASE_URL}advertisement_contents/"

    const val LOGIN = "${BASE_URL}login"
    const val REGISTER = "${BASE_URL}register"

    // forget password
    const val SEND_OTP = "${BASE_URL}send-otp"
    const val VERIFY_OTP = "${BASE_URL}confirm_code"
    const val FORGET_PASSWORD = "${BASE_URL}forget-password"

    //categories
    const val CATEGORIES = "${BASE_URL}categories"

    //services
    const val SERVICES = "${BASE_URL}services"
    const val SERVICE_BY_ID = "${BASE_URL}services/"
    const val SERVICE_BY_PROVIDER_ID = "${BASE_URL}providers/{id}/services"
    const val UPDATE_SERVICE_BY_ID = "${BASE_URL}services/"
    const val FILTER_SERVICE = "${BASE_URL}services/filter"
    const val DELETE_SERVICE = "${BASE_URL}services/"
    const val SERVICE_REVIEWS_BY_ID = "${BASE_URL}services/{id}/reviews"
    const val UPDATE_IMAGES_SERVICE = "${BASE_URL}services/upload_images"

    //service reviews
    const val SET_REVIEW_SERVICES = "${BASE_URL}service_reviews"

    //favorite services
    const val FAVORITE_SERVICES = "${BASE_URL}user_favorite_services"
    const val DELETE_FAVORITE_SERVICES = "${BASE_URL}favorite_services/"
    const val SET_FAVORITE_SERVICES = "${BASE_URL}favorite_services"

    //posts
    const val POSTS = "${BASE_URL}posts"
    const val POSTS_BY_PROVIDER_ID = "${BASE_URL}providers/posts"
    const val SET_POST = "${BASE_URL}posts"
    const val DELETE_POST = "${BASE_URL}posts/"
    const val SET_COMMENT = "${BASE_URL}post_comments"
    const val DELETE_COMMENT_BY_ID = "${BASE_URL}post_comments/"
    const val GET_COMMENT_POST_BY_ID = "${BASE_URL}posts/{id}/comments"
    const val SET_FAVORITE_POST = "${BASE_URL}favorite_posts"
    const val DELETE_FAVORITE_LIKES = "${BASE_URL}favorite_posts/{id}"

    //post_likes
    const val SET_POST_LIKES = "${BASE_URL}post_likes"
    const val DELETE_POST_LIKES = "${BASE_URL}post_likes/"

    //providers
    const val PROVIDERS = "${BASE_URL}providers"
    const val SHOW_PROVIDER = "${BASE_URL}providers/"
    const val UPDATE_PROVIDER = "${BASE_URL}providers/"

    //user
    const val SHOW_USER = "${BASE_URL}user_profile"
    const val GET_USER_BY_ID = "${BASE_URL}users/{id}"
    const val UPDATE_USER_IMAGE = "${BASE_URL}user/upload_user_image"
    const val UPDATE_USER_BACKGROUND_IMAGE = "${BASE_URL}user/upload_user_background_image"
    const val UPDATE_USER = "${BASE_URL}user_profile/update"

    //countries
    const val COUNTRIES = "${BASE_URL}countries"

    //cities
    const val CITIES = "${BASE_URL}cities"

    //provinces
    const val PROVINCES = "${BASE_URL}provinces"

    //interests
    const val INTERESTS = "${BASE_URL}interests"
    const val DELETE_INTEREST = "${BASE_URL}user/user_interests/{id}"
    const val SET_INTEREST = "${BASE_URL}user/user_interests"

    //advertisements
    const val ADVERTISEMENT = "${BASE_URL}advertisements"

    //service_reviews
    const val SET_SERVICE_REVIEWS = "${BASE_URL}service_reviews"
    const val DELETE_SERVICE_REVIEWS = "${BASE_URL}service_reviews/"


    //search
    const val SERVICE_SEARCH = "${BASE_URL}services/search"
    const val PROVIDERS_SEARCH = "${BASE_URL}providers/search"
    const val HOME_SEARCH = "${BASE_URL}home/search"

    //contacts
    const val CONTACTS = "${BASE_URL}contacts"

    //languages
    const val LANGUAGES = "${BASE_URL}languages"

    //currency
    const val CURRENCY = "${BASE_URL}currencies"

    //plans
    const val PLANS = "${BASE_URL}plans"

    //game
    const val GAME = "${BASE_URL}game_questions"

    //get_random_providers
    const val GET_RANDOM_PROVIDERS = "${BASE_URL}get_random_providers"
    const val SEND_PUSH_NOTIFICATION = "${BASE_URL}send_push_notification"
    const val UPDATE_FCM_TOKEN = "${BASE_URL}update_fcm_token"

    //report
    const val REPORT = "${BASE_URL}report-content"

    //settings
    const val TOKEN = "token"
    const val USER_ID = "userId"
    const val PROVIDERS_BLOCK_IDS = "providers_block_ids"
    const val USER_NAME = "userName"
    const val USER_EMAIL = "userEmail"
    const val USER_IMAGE = "userImage"
    const val USER_OBJECT = "userObject"


}