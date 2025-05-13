//
//  FirebaseViewModel.swift
//  iosApp
//
//  Created by Eslam Ghazy on 20/11/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import FirebaseDatabase
import ComposeApp

class FirebaseViewModel : ObservableObject {
    
    private let mainViewModel = MainViewModel()
    private let database = Database.database().reference()
    private var chatListenerHandle: DatabaseHandle?
    private let userDateViewModel: UserDataViewModel = UserDataViewModel()
    private let firebaseNotification: FirebaseNotificationViewModel = FirebaseNotificationViewModel()
    
    init() {
        self.updateFcmToken()
    }
    
    func readData(path: String, completion: @escaping (Chat?, String?) -> Void) {
        database.child(path).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists() else {
                completion(nil, "No data available at path: \(path)")
                return
            }
            
            do {
                // Convert snapshot.value to JSON data
                if let value = snapshot.value as? [String: Any] {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let chat = try JSONDecoder().decode(Chat.self, from: jsonData)
                    completion(chat, nil)
                } else {
                    completion(nil, "Data format mismatch")
                }
            } catch {
                completion(nil, "Failed to decode Chat: \(error.localizedDescription)")
            }
        }
    }
    
    func readAllChats(providerId : Int ,completion: @escaping (RequestState<[Chat]>) -> Void) {
        completion(.loading)
        let myId = userDateViewModel.getUserId()
        
        // Remove any existing listener
        if let chatListenerHandle = chatListenerHandle {
            database.child("/chat").removeObserver(withHandle: chatListenerHandle)
        }
        
        // Add a new listener
        chatListenerHandle = database.child("/chat").observe(.value) { snapshot in
            guard snapshot.exists() else {
                completion(.error("No data available at path: chat"))
                return
            }
            
            var chats: [Chat] = []
            
            // Iterate over each child in the snapshot
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let value = childSnapshot.value as? [String: Any] {
                    do {
                        // Convert value to JSON and decode to `Chat`
                        let jsonData = try JSONSerialization.data(withJSONObject: value)
                        let chat = try JSONDecoder().decode(Chat.self, from: jsonData)
                        // Filter by user ID
                        if (chat.from == myId && chat.to == providerId) || (chat.to == myId && chat.from == providerId) {
                            chats.append(chat)
                        }
                    } catch {
                        completion(.error("Failed to decode chat for child \(childSnapshot.key): \(error.localizedDescription)"))
                    }
                }
            }
            completion(.success(chats))
        }
    }
    
    func stopListeningToChats() {
        if let chatListenerHandle = chatListenerHandle {
            database.child("/chat").removeObserver(withHandle: chatListenerHandle)
            self.chatListenerHandle = nil
        }
    }
    
    func readMyChatList(completion: @escaping (RequestState<[ChatList]>) -> Void){
        completion(.loading)
        userDateViewModel.getUserID { id in
            self.database.child("chat-list/\(id)").observeSingleEvent(of: .value) { snapshot in
                guard snapshot.exists() else {
                    completion(.error("No data available at path: chat-list"))
                    return
                }
                var chats: [ChatList] = []
                // Iterate over each child in the snapshot
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let value = childSnapshot.value as? [String: Any] {
                        do {
                            // Convert value to JSON and decode to `Chat`
                            let jsonData = try JSONSerialization.data(withJSONObject: value)
                            let chat = try JSONDecoder().decode(ChatList.self, from: jsonData)
                            chats.append(chat)
                        } catch {
                            completion(.error("Failed to decode chat for child \(childSnapshot.key): \(error.localizedDescription)"))
                        }
                    }
                }
                completion(.success(chats))
            }
        }
    }
    
    func sendMessage(message:String , providerId:Int,completion: @escaping (RequestState<String>) -> Void){
        completion(.loading)
        do {
            // Convert Chat object to a dictionary
            let newChatRef = database.child("/chat").childByAutoId()
            let chat = Chat(from: Int(userDateViewModel.getUserId()), id: UUID().uuidString , text: "\(message)", to: providerId, type: 0)
            let jsonData = try JSONEncoder().encode(chat)
            guard let dictionary = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
                completion(.error("Failed to serialize chat object"))
                return
            }
            
            // Save the dictionary to Firebase
            newChatRef.setValue(dictionary) { error, _ in
                if let error = error {
                    completion(.error("Firebase error: \(error.localizedDescription)"))
                } else {
                    completion(.success("Done")) // Success
                    self.sendNotification(sendNotification: SendNotification(title: "Henna App", body: message, userId: Int32(providerId)))
                }
            }
        } catch {
            completion(.error("Encoding error: \(error.localizedDescription)"))
        }
    }
    
    func createChatList(
        providerId:Int,
        providerImage: String,
        providerName:String ,
        completion: @escaping (RequestState<String>) -> Void
    ){
        completion(.loading)
        do {
            var userData = userDateViewModel.getUserNormal()
            // for user
            let chatUser = ChatList(image: Constants().UsersImages + providerImage, name: providerName, user_id: "\(providerId)", time: TimeZone.current.secondsFromGMT())
            let jsonDataUser = try JSONEncoder().encode(chatUser)
            guard let dictionaryUser = try JSONSerialization.jsonObject(with: jsonDataUser) as? [String: Any] else {
                completion(.error("Failed to serialize chat object"))
                return
            }
            database.child("/chat-list")
                .child("\(userDateViewModel.getUserId())")
                .child("\(providerId)")
                .setValue(dictionaryUser){ error, _ in
                    if let error = error {
                        completion(.error("Firebase error: \(error.localizedDescription)"))
                    } else {
                        completion(.success("Done")) // Success
                    }
                }
            
            // for provider
            let chatProvider = ChatList(image: (Constants().UsersImages + (userData.user_image ?? "")), name: "\(String(describing: userData.first_name ?? "")) \(String(describing: userData.last_name ?? ""))" , user_id: "\(userDateViewModel.getUserId())", time: TimeZone.current.secondsFromGMT())
            let jsonDataProvider = try JSONEncoder().encode(chatProvider)
            guard let dictionaryProvider = try JSONSerialization.jsonObject(with: jsonDataProvider) as? [String: Any] else {
                completion(.error("Failed to serialize chat object"))
                return
            }
            self.database.child("/chat-list")
                .child("\(providerId)")
                .child("\(self.userDateViewModel.getUserId())")
                .setValue(dictionaryProvider){error, _ in
                    if let error = error {
                        completion(.error("Firebase error: \(error.localizedDescription)"))
                    } else {
                        completion(.success("Done")) // Success
                    }
                }
            
        } catch {
            completion(.error("Encoding error: \(error.localizedDescription)"))
        }
    }
    
    func deleteChatProvider(providerId:Int , completion: @escaping (RequestState<String>) -> Void){
        self.database.child("/chat-list")
            .child("\(self.userDateViewModel.getUserId())")
            .child("\(providerId)")
            .removeValue { error, db in
                if let error = error {
                    completion(.error("Firebase error: \(error.localizedDescription)"))
                } else {
                    completion(.success("Done")) // Success
                    self.database.child("/chat-list")
                        .child("\(providerId)")
                        .child("\(self.userDateViewModel.getUserId())")
                        .removeValue { error, db in
                            if let error = error {
                                completion(.error("Firebase error: \(error.localizedDescription)"))
                            } else {
                                completion(.success("Done")) // Success
                            }
                        }
                }
            }
    }
    
    func sendNotification(sendNotification:SendNotification){
        mainViewModel.sendNotification(sendNotification: sendNotification) { response in
            print("Done")
        } error: { error in
            print("\(error)")
        }
    }
    
    func updateFcmToken(){
        firebaseNotification.fcmToken { token in
            self.mainViewModel.updateFcmToken(updateFcmToken: UpdateFcmToken(fcmToken: token ?? "")) { response in
                print("Done")
            } error: { error in
                print("\(error)")
            }
        }
    }
}

struct Chat : Codable {
    let from : Int
    let id : String
    let text : String
    let to : Int
    let type : Int
}

struct ChatList : Codable {
    let image : String
    let name : String
    let user_id : String
    let time : Int
}
