//
//  MyForm.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 29.5.2023.
//

import Foundation
import SwiftUI

/**
 A view for displaying and editing user information in a style of a form.
 
 Component consists of textfields for each attributes and a submit button.
 */
struct MyFormView: View {
    /// The user object to be displayed and modified.
    var user: User
    /// Flag indicating if the form is in modify mode.
    var isModifyOn: Bool
    /// The HTTP client object for making API requests.
    @ObservedObject var 🖥️: HttpClient
    /// Flag indicating whether to show the success dialog.
    @State private var showDialog = false
    /// State variables for form fields.
    @State private var fname: String
    @State private var lname: String
    @State private var username: String
    @State private var age: String
    @State private var email: String
    @State private var phone: String
    @State private var height: String
    @State private var weight: String
    /// The validator object for field validation.
    @StateObject var validator: Validator
    
    /**
     Initializes a new instance of `MyFormView`.
     
     - Parameters:
        - user: The user object to be displayed and modified.
        - 🖥️: The HTTP client object for making API requests.
        - isModifyOn: Flag indicating if the form is in modify mode.
     */
    init(user: User, 🖥️: HttpClient, isModifyOn: Bool) {
        self.user = user
        self.🖥️ = 🖥️
        self.isModifyOn = isModifyOn
        /// Set initial values for form fields based on the user object.
        _fname = State(initialValue: user.firstName)
        _lname = State(initialValue: user.lastName)
        _username = State(initialValue: user.username)
        _age = State(
            initialValue: user.age != 0 ? String(user.age) : ""
        )
        _email = State(initialValue: user.email)
        _phone = State(initialValue: user.phone)
        _height = State(
            initialValue: user.height != 0 ? String(user.height) : ""
        )
        _weight = State(
            initialValue: user.weight != 0 ? String(user.weight) : ""
        )
        /// Create a new instance of the validator.
        _validator = StateObject(
            wrappedValue: Validator(initState: isModifyOn)
        )
    }

    var body: some View {
        Form {
            /// Personal Information Section
            Section(header: Text("Personal Information")) {
                TextField("", text: $fname)
                    .onChange(of: fname) { newValue in
                        user.updateValues(attr: "firstname", value: newValue)
                        validator.validateAll(user: user)
                    }
                    .labeledTextField(label: "First name")
                    .foregroundColor(
                        validator
                            .validateName(name: fname) ? .green : .red
                    )
                TextField("", text: $lname)
                    .onChange(of: lname) { newValue in
                        user.updateValues(attr: "lastname", value: newValue)
                        validator.validateAll(user: user)
                    }
                    .labeledTextField(label: "Last name")
                    .foregroundColor(
                        validator
                            .validateName(name: lname) ? .green : .red
                    )
                TextField("", text: $username)
                    .onChange(of: username) { newValue in
                        user.updateValues(attr: "username", value: newValue)
                        validator.validateAll(user: user)
                    }
                    .labeledTextField(label: "Username")
                    .foregroundColor(
                        validator
                            .validateUsername(username: username) ? .green : .red
                    )
                TextField("", text: $age)
                    .onChange(of: age) { newValue in
                        user.updateValues(attr: "age", value: newValue)
                        validator.validateAll(user: user)
                    }
                    .labeledTextField(label: "Age")
                    .foregroundColor(
                        validator
                            .validateAge(age: age) ? .green : .red
                    )
            }
            /// Contact Information Section
            Section(header: Text("Contact Information")) {
                TextField("", text: $email)
                    .onChange(of: email) { newValue in
                        user.updateValues(attr: "email", value: newValue)
                        validator.validateAll(user: user)
                    }
                    .labeledTextField(label: "Email")
                    .foregroundColor(
                        validator
                            .validateEmail(email: email) ? .green : .red
                    )
                TextField("", text: $phone)
                    .onChange(of: phone) { newValue in
                        user.updateValues(attr: "phone", value: newValue)
                        validator.validateAll(user: user)
                    }
                    .labeledTextField(label: "Phone number")
                    .foregroundColor(
                        validator
                            .validatePhone(phone: phone) ? .green : .red
                    )
            }
            /// Additional Information Section
            Section(header: Text("Additional Information")) {
                TextField("", text: $height)
                    .onChange(of: height) { newValue in
                        user.updateValues(attr: "height", value: newValue)
                        validator.validateAll(user: user)
                    }
                    .labeledTextField(label: "Height (cm)")
                    .foregroundColor(
                        validator
                            .validateHeight(height: height) ? .green : .red
                    )
                TextField("", text: $weight)
                    .onChange(of: weight) { newValue in
                        user.updateValues(attr: "weight", value: newValue)
                        validator.validateAll(user: user)
                    }
                    .labeledTextField(label: "Weight (kg)")
                    .foregroundColor(
                        validator
                            .validateWeight(weight: weight) ? .green : .red
                    )
            }
            /// Submit button
            Section {
                Button("Submit") {
                    showDialog = true
                    if (isModifyOn) {
                        🖥️.putUser(
                            url: "https://dummyjson.com/users/\(user.id)",
                            user: user
                        )
                    } else {
                        🖥️.postUser(user: user)
                    }
                }
                .disabled(!validator.allFieldsValid)
            }
        }
        .onDisappear {
            /// Reset form when leaving form view
            resetForm()
        }
        .alert(isPresented: $showDialog) {
            Alert(
                title: Text("User modified"),
                message: Text("Success!")
            )
        }
    }
    
    /**
     Resets the form fields and validator state.
     */
    private func resetForm() {
        fname = ""
        lname = ""
        username = ""
        age = ""
        email = ""
        phone = ""
        height = ""
        weight = ""
        validator.allFieldsValid = false
    }
}
