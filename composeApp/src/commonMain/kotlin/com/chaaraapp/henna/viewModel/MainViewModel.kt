package com.chaaraapp.henna.viewModel

import cafe.adriel.voyager.core.model.ScreenModel
import cafe.adriel.voyager.core.model.screenModelScope
import com.chaaraapp.henna.domain.model.Message
import com.chaaraapp.henna.domain.model.Search
import com.chaaraapp.henna.domain.model.UserId
import com.chaaraapp.henna.domain.model.advertisements.AdvertisementList
import com.chaaraapp.henna.domain.model.auth.forgetPassword.Email
import com.chaaraapp.henna.domain.model.auth.forgetPassword.OTP
import com.chaaraapp.henna.domain.model.auth.login.LoginCallback
import com.chaaraapp.henna.domain.model.auth.login.LoginModel
import com.chaaraapp.henna.domain.model.auth.register.Register
import com.chaaraapp.henna.domain.model.categories.CategoriesList
import com.chaaraapp.henna.domain.model.countries.CountriesList
import com.chaaraapp.henna.domain.model.countries.provinces.ProvincesList
import com.chaaraapp.henna.domain.model.countries.provinces.cities.CityList
import com.chaaraapp.henna.domain.model.currencies.CurrenciesList
import com.chaaraapp.henna.domain.model.fcm.MyResponse
import com.chaaraapp.henna.domain.model.game.GameList
import com.chaaraapp.henna.domain.model.home.HomeCallback
import com.chaaraapp.henna.domain.model.home.SearchHome
import com.chaaraapp.henna.domain.model.interests.add.AddInterest
import com.chaaraapp.henna.domain.model.interests.list.InterestsList
import com.chaaraapp.henna.domain.model.languages.LanguagesList
import com.chaaraapp.henna.domain.model.notification.SendNotification
import com.chaaraapp.henna.domain.model.notification.UpdateFcmToken
import com.chaaraapp.henna.domain.model.plans.PlansList
import com.chaaraapp.henna.domain.model.posts.comment.Comment
import com.chaaraapp.henna.domain.model.posts.commentOfPost.CommentsList
import com.chaaraapp.henna.domain.model.posts.favorite.FavoritePost
import com.chaaraapp.henna.domain.model.posts.post.Post
import com.chaaraapp.henna.domain.model.posts.post.PostsList
import com.chaaraapp.henna.domain.model.providers.provider.ProviderList
import com.chaaraapp.henna.domain.model.providers.random.RandomProvider
import com.chaaraapp.henna.domain.model.providers.show.ProviderModelData
import com.chaaraapp.henna.domain.model.report.SendReport
import com.chaaraapp.henna.domain.model.services.favorite.AddServiceFavorite
import com.chaaraapp.henna.domain.model.services.favorite.favoriteService.FavoriteServiceList
import com.chaaraapp.henna.domain.model.services.filter.FilterList
import com.chaaraapp.henna.domain.model.services.filter.FilterService
import com.chaaraapp.henna.domain.model.services.review.PostReview
import com.chaaraapp.henna.domain.model.services.reviewsOfService.ReviewsListService
import com.chaaraapp.henna.domain.model.services.service.ServiceList
import com.chaaraapp.henna.domain.model.services.service.ServiceModelData
import com.chaaraapp.henna.domain.model.user.UpdateProvider
import com.chaaraapp.henna.domain.model.user.UpdateUser
import com.chaaraapp.henna.domain.model.user.UserModel
import com.chaaraapp.henna.getSettings
import com.chaaraapp.henna.utils.Constants
import com.chaaraapp.henna.utils.Constants.BASE_URL
import com.chaaraapp.henna.utils.SettingsManager
import com.chaaraapp.henna.utils.createHttpClient
import com.skydoves.sandwich.ktor.bodyString
import com.skydoves.sandwich.ktor.deleteApiResponse
import com.skydoves.sandwich.ktor.getApiResponse
import com.skydoves.sandwich.ktor.postApiResponse
import com.skydoves.sandwich.ktor.putApiResponse
import com.skydoves.sandwich.ktor.statusCode
import com.skydoves.sandwich.message
import com.skydoves.sandwich.suspendOnError
import com.skydoves.sandwich.suspendOnException
import com.skydoves.sandwich.suspendOnFailure
import com.skydoves.sandwich.suspendOnSuccess
import io.kamel.core.utils.File
import io.ktor.client.HttpClient
import io.ktor.client.request.forms.formData
import io.ktor.client.request.parameter
import io.ktor.client.request.setBody
import kotlinx.coroutines.launch


class MainViewModel() : ScreenModel {

    private val settingsManager: SettingsManager = SettingsManager(getSettings())
    private val client: HttpClient = createHttpClient(settingsManager)

    //////////////////////////////////////////////// auth ////////////////////////////////////////////////

    fun login(
        loginModel: LoginModel,
        response: (LoginCallback) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<LoginCallback>(Constants.LOGIN) {
            setBody(loginModel)
        }.suspendOnSuccess {
            response(data)
            data.user?.device_token?.let { settingsManager.saveString(Constants.TOKEN, it) }
            data.user?.id?.let { settingsManager.saveInt(Constants.USER_ID, it) }
            data.user?.let {
                settingsManager.saveUser(it)
            }
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
//            log(message())
        }.suspendOnException {
//            error(message ?: "")
//            log(message())
        }.suspendOnFailure {
//            //error(message())
//            log(message())
        }
    }

    fun registerUser(
        registerModel: Register, response: (LoginCallback) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<LoginCallback>(Constants.REGISTER) {
            setBody(registerModel)
        }.suspendOnSuccess {
            response(data)
            data.user?.device_token?.let { settingsManager.saveString(Constants.TOKEN, it) }
            data.user?.id?.let { settingsManager.saveInt(Constants.USER_ID, it) }
            data.user?.let {
                settingsManager.saveUser(it)
            }
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    ////////////////////////////////////////////////// forgetPassword ////////////////////////////////////////////////

    fun sendOTP(
        email: Email, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.SEND_OTP) {
            setBody(email)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun verifyOtp(
        otp: OTP, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.SEND_OTP) {
            setBody(otp)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun forgetPassword(
        email: Email, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.FORGET_PASSWORD) {
            setBody(email)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    ////////////////////////////////////////////////// user ////////////////////////////////////////////////
    fun showUser(
        response: (UserModel) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<UserModel>(Constants.SHOW_USER) {
            //
        }.suspendOnSuccess {
            response(data)
            data.data?.let {
                settingsManager.saveUser(it)
            }
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun updateUser(
        updateUser: UpdateUser, response: (UserModel) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<UserModel>(Constants.UPDATE_USER) {
            //
            setBody(updateUser)
        }.suspendOnSuccess {
            response(data)
            data.data?.device_token?.let { settingsManager.saveString(Constants.TOKEN, it) }
            data.data?.id?.let { settingsManager.saveInt(Constants.USER_ID, it) }
            data.data?.let {
                settingsManager.saveUser(it)
            }
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun getUserById(
        id: String, response: (UserModel) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<UserModel>(Constants.GET_USER_BY_ID) {
            parameter("id", id)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            //error(message())
            log(message())
        }.suspendOnException {
            //error(message())
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun uploadBackgroundImageUser(
        image: File, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.UPDATE_USER_BACKGROUND_IMAGE) {
            formData {
//                append("image", image.readBytes(), image.name)
            }
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    ////////////////////////////////////////////////// search ////////////////////////////////////////////////
    fun homeSearch(
        searchHome: SearchHome,
        response: (HomeCallback) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<HomeCallback>(Constants.HOME_SEARCH) {
            setBody(searchHome)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }


    ////////////////////////////////////////////////// categories ////////////////////////////////////////////////
    fun getCategoriesList(
        response: (CategoriesList) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<CategoriesList>(Constants.CATEGORIES) {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    ////////////////////////////////////////////////// provider ////////////////////////////////////////////////
    fun getProvidersList(response: (ProviderList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<ProviderList>(Constants.PROVIDERS) {
                //
            }.suspendOnSuccess {
                response(data)
                response(ProviderList(data = data.data.filterNot {
                    settingsManager.getProvidersBlockIds().contains(it.id)
                }))
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    fun showProvider(
        id: String, response: (ProviderModelData) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<ProviderModelData>(Constants.SHOW_PROVIDER + id) {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun updateProvider(
        id: String,
        updateProvider: UpdateProvider,
        response: (Message) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.putApiResponse<Message>(Constants.UPDATE_PROVIDER + id) {
            setBody(updateProvider)

        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun getRandomProvider(
        response: (RandomProvider) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<RandomProvider>(Constants.GET_RANDOM_PROVIDERS) {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    ////////////////////////////////////////////////// service ////////////////////////////////////////////////
    fun getService(response: (ServiceList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<ServiceList>(Constants.SERVICES) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    fun getServiceById(
        id: String, response: (ServiceModelData) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<ServiceModelData>(Constants.SERVICE_BY_ID + id) {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun getServiceByProviderId(
        id: Int, response: (ServiceList) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<ServiceList>("${BASE_URL}providers/$id/services") {

        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun servicesFilter(
        filterService: FilterService,
        response: (FilterList) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<FilterList>(Constants.FILTER_SERVICE) {

            setBody(filterService)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun getServiceSearch(
        filterService: FilterService,
        response: (ServiceList) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<ServiceList>(Constants.SERVICE_SEARCH) {
            setBody(filterService)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun getProvidersSearch(
        serviceSearch: Search,
        response: (ProviderList) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<ProviderList>(Constants.PROVIDERS_SEARCH) {
            setBody(serviceSearch)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun deleteService(
        id: String,
        response: (Message) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.deleteApiResponse<Message>(Constants.DELETE_SERVICE + id) {
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    ////////////////////////////////////////////////// reviews ////////////////////////////////////////////////
    fun setReview(
        postReview: PostReview, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.SET_REVIEW_SERVICES) {
            setBody(postReview)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun getReviewsServiceById(
        id: Int, response: (ReviewsListService) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<ReviewsListService>("${BASE_URL}services/$id/reviews") {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun deleteServiceReviews(
        id: String, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.deleteApiResponse<Message>(Constants.DELETE_SERVICE_REVIEWS + id) {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }


    ////////////////////////////////////////////////// posts ////////////////////////////////////////////////
    fun getPosts(response: (PostsList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<PostsList>(Constants.POSTS) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    fun getPostsByProviderId(
        userId: Int, response: (PostsList) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<PostsList>(Constants.POSTS_BY_PROVIDER_ID) {
            setBody(UserId(userId))
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun setPost(
        description: String,
        type: String,
        content: File?,
        response: (Post) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Post>(Constants.SET_POST) {
            formData {

            }
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun deletePost(id: Int, response: (Message) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.deleteApiResponse<Message>(Constants.DELETE_POST + id) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    fun setComment(
        comment: Comment, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.SET_COMMENT) {
            setBody(comment)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun deleteCommentById(
        id: Int, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.deleteApiResponse<Message>(Constants.DELETE_COMMENT_BY_ID + id) {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun getCommentPostById(
        id: Int, response: (CommentsList) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<CommentsList>("${BASE_URL}posts/$id/comments") {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun setFavoritePost(
        favoritePost: FavoritePost,
        response: (Message) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.SET_FAVORITE_POST) {
            setBody(favoritePost)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun deletePostLikes(id: Int, response: (Post) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.deleteApiResponse<Post>(Constants.DELETE_POST_LIKES + id) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    fun setPostLikes(
        favoritePost: FavoritePost, response: (Post) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Post>(Constants.SET_POST_LIKES) {
            setBody(favoritePost)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    ////////////////////////////////////////////////// favorite ////////////////////////////////////////////////
    fun setFavoriteServices(
        favorite: AddServiceFavorite, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.SET_FAVORITE_SERVICES) {
            setBody(favorite)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun deleteFavoriteServices(
        id: String, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.deleteApiResponse<Message>(Constants.DELETE_FAVORITE_SERVICES + id) {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun getFavoriteServices(
        response: (FavoriteServiceList) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<FavoriteServiceList>(Constants.FAVORITE_SERVICES) {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }


    ////////////////////////////////////////////////// advertisements ////////////////////////////////////////////////
    fun getAdvertisements(
        response: (AdvertisementList) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.getApiResponse<AdvertisementList>(Constants.ADVERTISEMENT) {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }


    ////////////////////////////////////////////////// interest ////////////////////////////////////////////////
    fun getInterestsList(response: (InterestsList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<InterestsList>(Constants.INTERESTS) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }


    fun deleteInterest(
        id: String, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.deleteApiResponse<Message>("${BASE_URL}user/user_interests/$id") {
            //
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun setInterest(
        addInterest: AddInterest, response: (Message) -> Unit, error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.SET_INTEREST) {
            setBody(addInterest)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }


    ////////////////////////////////////////////////// countries ////////////////////////////////////////////////
    fun getCountriesList(response: (CountriesList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<CountriesList>(Constants.COUNTRIES) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    ////////////////////////////////////////////////// cities ////////////////////////////////////////////////
    fun getCitiesList(response: (CityList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<CityList>(Constants.CITIES) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    ////////////////////////////////////////////////// province ////////////////////////////////////////////////
    fun getProvincesList(response: (ProvincesList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<ProvincesList>(Constants.PROVINCES) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    ////////////////////////////////////////////////// language ////////////////////////////////////////////////
    fun getLanguages(response: (LanguagesList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<LanguagesList>(Constants.LANGUAGES) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    ////////////////////////////////////////////////// currancy ////////////////////////////////////////////////
    fun getCurrency(response: (CurrenciesList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<CurrenciesList>(Constants.CURRENCY) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }


    ////////////////////////////////////////////////// plans ////////////////////////////////////////////////
    fun getPlans(response: (PlansList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<PlansList>(Constants.PLANS) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    ////////////////////////////////////////////////// game ////////////////////////////////////////////////
    fun getGameList(response: (GameList) -> Unit, error: (String) -> Unit) =
        screenModelScope.launch {
            client.getApiResponse<GameList>(Constants.GAME) {
                //
            }.suspendOnSuccess {
                response(data)
            }.suspendOnError {
                log(bodyString())
                log(statusCode.code)
                error(bodyString())
                log(message())
            }.suspendOnException {
                //error(message ?: "")
                log(message())
            }.suspendOnFailure {
                //error(message())
                log(message())
            }
        }

    ////////////////////////////////////////////////// notification ////////////////////////////////////////////////
    fun sendNotification(
        sendNotification: SendNotification,
        response: (MyResponse) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<MyResponse>(Constants.SEND_PUSH_NOTIFICATION) {
            //
            setBody(sendNotification)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    fun updateFcmToken(
        updateFcmToken: UpdateFcmToken,
        response: (Message) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.UPDATE_FCM_TOKEN) {
            //
            setBody(updateFcmToken)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    //send report
    fun sendReport(
        sendReport: SendReport,
        response: (Message) -> Unit,
        error: (String) -> Unit
    ) = screenModelScope.launch {
        client.postApiResponse<Message>(Constants.REPORT) {
            setBody(sendReport)
        }.suspendOnSuccess {
            response(data)
        }.suspendOnError {
            log(bodyString())
            log(statusCode.code)
            error(bodyString())
            log(message())
        }.suspendOnException {
            //error(message ?: "")
            log(message())
        }.suspendOnFailure {
            //error(message())
            log(message())
        }
    }

    private fun <T> log(data: T) {
        println("$TAG , $data")
    }

    companion object {
        private const val TAG = "MainViewModel"
    }

}
