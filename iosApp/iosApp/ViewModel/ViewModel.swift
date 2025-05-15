//
//  AuthViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 7/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import ComposeApp

class ViewModel : ObservableObject {
    
    
    private let mainViewModel: MainViewModel = MainViewModel()
    private let settingsViewModel : SettingsViewModel = SettingsViewModel()
    
    //MARK: Auth
    func signin(
        login: LoginModel,
        completion: @escaping (RequestState<LoginCallback>) -> Void
    ){
        completion(.loading)
        mainViewModel.login(loginModel: login) { requestState in
            completion(.success(requestState))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func signup(
        register: Register,
        completion: @escaping (RequestState<LoginCallback>) -> Void
    ){
        completion(.loading)
        mainViewModel.registerUser(registerModel: register) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
        
    }
    
    //MARK: USER
    func showUser(completion: @escaping (RequestState<UserModel>) -> Void){
        completion(.loading)
        mainViewModel.showUser { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func updateUser(updateUser: UpdateUser , completion: @escaping (RequestState<UserModel>) -> Void){
        completion(.loading)
        mainViewModel.updateUser(updateUser: updateUser) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    
    //MARK: CAREGORY
    func categoryList(completion: @escaping (RequestState<CategoriesList>) -> Void){
        completion(.loading)
        mainViewModel.getCategoriesList { list in
            completion(.success(list))
        } error: { error in
            completion(.error(error))
        }

    }
    
    
    //MARK: SERVICE
    func serviceList(completion: @escaping (RequestState<ServiceList>) -> Void){
        completion(.loading)
        mainViewModel.getService { list in
            completion(.success(list))
        } error: { error in
            completion(.error(error))
        }

    }
    func showServiceById(id:Int,completion: @escaping (RequestState<ServiceModelData>) -> Void){
        completion(.loading)
        mainViewModel.getServiceById(id: "\(id)") { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    func deleteService(id:String,completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.deleteService(id: id) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    //MARK: FILTER SERVICE
    func serviceFilter(filterService: FilterService,completion: @escaping (RequestState<FilterList>) -> Void){
        completion(.loading)
        mainViewModel.servicesFilter(filterService: filterService) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    func setFavoriteServices(addServiceFavorite: AddServiceFavorite ,completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.setFavoriteServices(favorite: addServiceFavorite) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func deleteFavoriteServices(id: String , completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.deleteFavoriteServices(id: id) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    func getFavoriteServices(completion: @escaping (RequestState<FavoriteServiceList>) -> Void){
        completion(.loading)
        mainViewModel.getFavoriteServices { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    
    //MARK: COMMENT SERVICE
    func getReviewsServiceById(id: Int32,completion: @escaping (RequestState<ReviewsListService>) -> Void){
        completion(.loading)
        mainViewModel.getReviewsServiceById(id: id) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func addReview(postReview:PostReview,completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.setReview(postReview: postReview) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func deleteReview(id:Int , completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.deleteServiceReviews(id: "\(id)") { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    //MARK: PROVIDER
    func providerList(completion: @escaping (RequestState<ProviderList>) -> Void){
        completion(.loading)
        mainViewModel.getProvidersList { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func providerRandomList(completion: @escaping (RequestState<RandomProvider>) -> Void){
        completion(.loading)
        mainViewModel.getRandomProvider(response: { response in
            completion(.success(response))
        }, error: { error in
            completion(.error(error))
        })
    }
    
    
    func showProviderById(id:Int,completion: @escaping (RequestState<ProviderModelData>) -> Void){
        completion(.loading)
        mainViewModel.showProvider(id: "\(id)") { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func updateProvider(id: String, updateProvider: UpdateProvider, completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.updateProvider(id: id, updateProvider: updateProvider) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    //MARK: SEARCH PROVIDER
    func getProvidersSearch(search_input : String , completion: @escaping (RequestState<ProviderList>) -> Void){
        completion(.loading)
        mainViewModel.getProvidersSearch(serviceSearch: Search(search_input: search_input)) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    //MARK: SERACH HOME
    func homeSearch(name:String,completion: @escaping (RequestState<HomeCallback>) -> Void){
        completion(.loading)
        mainViewModel.homeSearch(searchHome: SearchHome(name: "")) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    
    //MARK: POSTS
    func posts(completion: @escaping (RequestState<PostsList>) -> Void){
        completion(.loading)
        mainViewModel.getPosts { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    func getPostsByProviderId(userId:Int32,completion: @escaping (RequestState<PostsList>) -> Void){
        completion(.loading)
        mainViewModel.getPostsByProviderId(userId: userId) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func setPostLike(postId:Int32,completion: @escaping (RequestState<Post_>) -> Void){
        completion(.loading)
        mainViewModel.setPostLikes(favoritePost: FavoritePost(post_id: postId)) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    func deletePostLike(postId:Int32,completion: @escaping (RequestState<Post_>) -> Void){
        completion(.loading)
        mainViewModel.deletePostLikes(id: postId) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func deletePost(id:Int32 , completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.deletePost(id: id) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    //MARK: COMMENTS POSTS
    func setComment(comment: Comment, completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.setComment(comment: comment) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    func getCommentPostById(id: Int32, completion: @escaping (RequestState<CommentsList>) -> Void){
        completion(.loading)
        mainViewModel.getCommentPostById(id: id) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    func deleteCommentById(id: Int32,completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.deleteCommentById(id: id) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    //MARK: INTEREST
    func getInterestsList(completion: @escaping (RequestState<InterestsList>) -> Void){
        completion(.loading)
        mainViewModel.getInterestsList { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    func deleteInterest(id:String , completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.deleteInterest(id: id) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    func setInterest(addInterest: AddInterest , completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.setInterest(addInterest: addInterest) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    
    //MARK: COUNTRY
    func countries(completion: @escaping (RequestState<CountriesList>) -> Void){
        completion(.loading)
        mainViewModel.getCountriesList { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    //MARK: PROVINCE
    func provinces(completion: @escaping (RequestState<ProvincesList>) -> Void){
        completion(.loading)
        mainViewModel.getProvincesList { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    //MARK: CITY
    func cities(completion: @escaping (RequestState<CityList>) -> Void){
        completion(.loading)
        mainViewModel.getCitiesList { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    //MARK: LANGAUGES
    func languages(completion: @escaping (RequestState<LanguagesList>) -> Void){
        completion(.loading)
        mainViewModel.getLanguages { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    //MARK: GAME
    func game(completion: @escaping (RequestState<GameList>) -> Void){
        completion(.loading)
        mainViewModel.getGameList { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }

    }
    
    //MARK: ADVERTISEMENT
    func getAdv(completion: @escaping (RequestState<AdvertisementList>) -> Void){
        completion(.loading)
        mainViewModel.getAdvertisements { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    //MARK: CURRENCY
    func getCurrency(completion: @escaping (RequestState<CurrenciesList>) -> Void){
        completion(.loading)
        mainViewModel.getCurrency { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
    
    //report
    func sendReport(sendReport:SendReport,completion: @escaping (RequestState<Message>) -> Void){
        completion(.loading)
        mainViewModel.sendReport(sendReport: sendReport) { response in
            completion(.success(response))
        } error: { error in
            completion(.error(error))
        }
    }
}

