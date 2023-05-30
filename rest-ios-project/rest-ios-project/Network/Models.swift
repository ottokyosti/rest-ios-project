//
//  Models.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 9.5.2023.
//

import Foundation
import Alamofire

/**
 A class responsible for handling HTTP requests to a server.
 
 Use this class to perform various HTTP operations such as
 fetching user data, adding users, updating users, and deleting users.
 */
class HttpClient: ObservableObject {
    /// The array of user data received from the server.
    @Published var userData: Array<User>? = nil
    /// A boolean indicating whether the delete operation was successful.
    @Published var isDeleteSuccess = false
    
    /**
     Fetches the initial user data from the server.
     
     - Parameter url: The URL to fetch the data from.
     */
    func getFirst(url: String) {
        AF.request(url).responseDecodable(of: Users.self) { response in
            guard let data = response.value else { return }
            self.userData = data.users
        }
    }
    
    /**
     Loads more user data from the server and appends it to existing user data.
     
     - Parameter url: The URL to fetch the additional data from.
     */
    func loadMore(url: String) {
        AF.request(url).responseDecodable(of: Users.self) { response in
            guard let data = response.value else { return }
            self.userData!.append(contentsOf: data.users)
        }
    }
    
    /**
     Deletes a user from the server.
     
     - Parameter url: The URL of the user to be deleted.
     */
    func deleteUser(url: String) {
        AF.request(url, method: .delete).response { response in
            switch(response.result) {
            case .success:
                self.isDeleteSuccess = true
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    /**
     Adds a new user to the server.
     
     - Parameter user: The user object to be added.
     */
    func postUser(user: User) {
        let url = "https://dummyjson.com/users/add"
        AF.request(url,
                   method: .post,
                   parameters: user,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
        }
    }
    
    /**
     Updates a user on the server.
     
     - Parameters:
        - url: The URL of the user to be updated.
        - user: The updated user object.
     */
    func putUser(url: String, user: User) {
        AF.request(url,
                   method: .put,
                   parameters: user,
                   encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
        }
    }
}
