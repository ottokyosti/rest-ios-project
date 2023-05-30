//
//  Validator.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation

/**
 A class responsible for validating user input fields.
 
 Use this class to validate various user attributes such as
 name, age, username, email, phone, height, and weight.
 The class provides methods for validating each attribute
 individually as well as a method to validate all fields at once.
 */
class Validator: ObservableObject {
    /// A boolean indicating whether all fields are valid.
    @Published var allFieldsValid: Bool
    
    /**
     Initializes the validator with an initial state for `allFieldsValid`.
     
     - Parameter initState: The initial state of whether modify is on or off.
     */
    init(initState: Bool) {
        self.allFieldsValid = initState
    }
    
    /**
     Validates all user fields and updates `allFieldsValid` accordingly.
     
     - Parameter user: The user object containing the input values to validate.
     */
    func validateAll(user: User) {
        let isNameValid = validateName(name: user.firstName)
            && validateName(name: user.lastName)
        let isAgeValid = validateAge(age: String(user.age))
        let isUsernameValid = validateUsername(username: user.username)
        let isEmailValid = validateEmail(email: user.email)
        let isPhoneValid = validatePhone(phone: user.phone)
        let isHeightValid = validateHeight(height: String(user.height))
        let isWeightValid = validateWeight(weight: String(user.weight))
        
        allFieldsValid = isNameValid && isAgeValid && isUsernameValid &&
            isEmailValid && isPhoneValid && isHeightValid && isWeightValid
    }
    
    /**
     Validates a name string using regular expression.
     
     - Parameter name: The name string to validate.
     - Returns: `true` if the name is valid, `false` otherwise.
     */
    func validateName(name: String) -> Bool {
        let regex = "^[A-Za-z\\-']{1,25}+$"
        let options = String.CompareOptions.regularExpression
        
        return name.range(of: regex, options: options) != nil
    }
    
    /**
     Validates a username string by checking whether it is empty or not..
     
     - Parameter username: The username string to validate.
     - Returns: `true` if the username is valid, `false` otherwise.
     */
    func validateUsername(username: String) -> Bool {
        return username != ""
    }
    
    /**
     Validates an age string using a specific range.
     
     - Parameter age: The age string to validate.
     - Returns: `true` if the age is valid, `false` otherwise.
     */
    func validateAge(age: String) -> Bool {
        guard let ageInt = Int(age) else { return false }
        return (1...149).contains(ageInt)
    }
    
    /**
     Validates an email string usign regular expression.
     
     - Parameter email: The email string to validate.
     - Returns: `true` if the email is valid, `false` otherwise.
     */
    func validateEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let options = String.CompareOptions.regularExpression
        
        return email.range(of: regex, options: options) != nil
    }
    
    /**
     Validates a phone number string using regular expression.
     
     - Parameter phone: The phone number string to validate.
     - Returns: `true` if the phone number is valid, `false` otherwise.
     */
    func validatePhone(phone: String) -> Bool {
        let regex = "^(\\+)?\\d{3,25}$"
        let options = String.CompareOptions.regularExpression
        let strippedPhone = phone.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
        
        return strippedPhone.range(of: regex, options: options) != nil
    }
    
    /**
     Validates a height string using a specific range.
     
     - Parameter height: The height string to validate.
     - Returns: `true` if the height is valid, `false` otherwise.
     */
    func validateHeight(height: String) -> Bool {
        guard let heightInt = Int(height) else { return false }
        return (40...300).contains(heightInt)
    }
    
    /**
     Validates a weight string using a specific range..
     
     - Parameter weight: The weight string to validate.
     - Returns: `true` if the weight is valid, `false` otherwise.
     */
    func validateWeight(weight: String) -> Bool {
        guard let weightDouble = Double(weight) else { return false }
        return (3.0...700.0).contains(weightDouble)
    }
}
