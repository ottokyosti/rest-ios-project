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
                    Label("keskel", systemImage: "cloud.fill")
                }
            
            TestView()
                .tabItem {
                    Label("oikeel", systemImage: "moon.fill")
                }
        }
    }
}

struct MainView: View {
    @StateObject var client = HttpClient()
    
    var body: some View {
        List {
            if let userData = client.userData {
                ForEach(userData, id: \.id) { user in
                    ListView(user: user)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            client.getAll(url: "https://dummyjson.com/users")
        }
    }
}

struct ListView: View {
    var user : User
    
    var body: some View {
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
            VStack (alignment: .leading) {
                Text("\(user.firstName) \(user.lastName)")
                    .fontWeight(.bold)
                Text("Age: \(user.age)")
            }
            .padding(2)
            Spacer()
        }
    }
}

struct TestView: View {
    var body: some View {
        Text("hello")
    }
}
