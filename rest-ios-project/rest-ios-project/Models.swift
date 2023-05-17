//
//  Models.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 9.5.2023.
//

import Foundation
import Alamofire

class HttpClient: ObservableObject {
    @Published var userData: Array<User>? = nil
    @Published var isDeleteSuccess = false
    
    func getAll(url: String) {
        AF.request(url).responseDecodable(of: Users.self) { response in
            guard let data = response.value else { return }
            self.userData = data.users
        }
    }
    
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
}
