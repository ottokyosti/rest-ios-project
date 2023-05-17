//
//  ContentView.swift
//  rest-ios-project
//
//  Created by Otto Kyösti on 9.5.2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            TestView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            TestView()
                .tabItem {
                    Label("Add user", systemImage: "person.fill.badge.plus")
                }
        }
    }
}

struct MainView: View {
    @StateObject var client = HttpClient()
    @State var showTrashIcons = false
    
    var body: some View {
        NavigationView {
            MainContent(client: client, showTrashIcons: $showTrashIcons)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                showTrashIcons = !showTrashIcons
                            } label: {
                                if (!showTrashIcons) {
                                    Image(systemName: "trash")
                                        .foregroundColor(Color.black)
                                } else {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(Color.black)
                                }
                            }
                        }
                    }
                }
        }
        .onAppear {
            client.getAll(url: "https://dummyjson.com/users")
        }
    }
}

struct MainContent: View {
    @ObservedObject var client: HttpClient
    @Binding var showTrashIcons: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                if let userData = client.userData {
                    ForEach(userData, id: \.id) { user in
                        ListView(user: user,
                                 showTrashIcons: $showTrashIcons,
                                 client: client)
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
    }
}

struct ListView: View {
    var user: User
    @Binding var showTrashIcons: Bool
    @ObservedObject var client: HttpClient
    
    var body: some View {
        ZStack {
            Color.white
            HStack {
                AsyncImage(url: URL(string: user.image), content: { image in
                    image.resizable()
                }, placeholder: {
                    ProgressView()
                })
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(.blue, lineWidth: 2)
                )
                VStack(alignment: .leading) {
                    Text("\(user.firstName) \(user.lastName)")
                        .fontWeight(.bold)
                    Text("Age: \(user.age)")
                }
                .padding(2)
                Spacer()
                MyDeleteButton(user: user,
                               showTrashIcons: $showTrashIcons,
                               client: client)
            }
            .padding(10)
        }
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 4)
    }
}

struct MyDeleteButton: View {
    var user: User
    @State var showConfirmDialog = false
    @Binding var showTrashIcons: Bool
    @ObservedObject var client: HttpClient
    
    var body: some View {
        Button {
            showConfirmDialog = !showConfirmDialog
        } label: {
            Image(systemName: "trash")
                .foregroundColor(Color.black)
                .scaleEffect(showTrashIcons ? 1.25 : 0.001)
                .animation(.spring(), value: showTrashIcons)
        }
        .disabled(!showTrashIcons)
        .padding(5)
        .alert(isPresented: $showConfirmDialog) {
            Alert(
                title: Text("Deleting user"),
                message: Text("Are you sure?"),
                primaryButton: .default(Text("Confirm")) {
                    client.deleteUser(url: "https://dummyjson.com/users/\(user.id)")
                },
                secondaryButton: .default(Text("Cancel")) {
                    showConfirmDialog = false
                }
            )
        }
    }
}

struct TestView: View {
    var body: some View {
        Text("hello")
    }
}
