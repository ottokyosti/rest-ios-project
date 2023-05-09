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
    
    func getAll(url: String) {
        AF.request(url).responseDecodable(of: Users.self) { response in
            guard let data = response.value else { return }
            self.userData = data.users
        }
    }
}
