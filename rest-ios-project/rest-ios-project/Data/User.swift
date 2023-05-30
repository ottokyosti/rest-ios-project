//
//  User.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 9.5.2023.
//

/**
 A class representing a user.
 */
class User: Codable {
    /// The unique identifier of the user.
    var id: Int
    /// The first name of the user.
    var firstName: String
    /// The last name of the user.
    var lastName: String
    /// The age of the user.
    var age: Int
    /// The username of the user.
    var username: String
    /// The email address of the user.
    var email: String
    /// The phone number of the user.
    var phone: String
    /// The height of the user in centimeters.
    var height: Int
    /// The weight of the user in kilograms.
    var weight: Double
    /// The image URL of the user.
    var image: String
    
    /**
     Initializes a new instance of the `User` class with default values.
     */
    init() {
        self.id = 0
        self.firstName = ""
        self.lastName = ""
        self.age = 0
        self.username = ""
        self.email = ""
        self.phone = ""
        self.height = 0
        self.weight = 0
        self.image = ""
    }
    
    /**
     Updates the attribute of the user with the specified value.
     
     - Parameters:
        - attr: The attribute to update.
        - value: The new value for the attribute.
     */
    func updateValues(attr: String, value: String) {
        switch attr {
        case "firstname":
            self.firstName = value
        case "lastname":
            self.lastName = value
        case "age":
            self.age = Int(value) ?? 0
        case "username":
            self.username = value
        case "email":
            self.email = value
        case "phone":
            self.phone = value
        case "height":
            self.height = Int(value) ?? 0
        case "weight":
            self.weight = Double(value) ?? 0
        default:
            print("Error: attribute not found")
        }
    }
}
