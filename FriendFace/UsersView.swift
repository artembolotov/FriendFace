//
//  ContentView.swift
//  FriendFace
//
//  Created by artembolotov on 26.02.2023.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var model = UsersViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.users) { user in
                    NavigationLink {
                        UserDetailsView(user: user)
                    } label: {
                        UserCell(user: user)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Users")
        }
        .task {
           await model.fetchUsers()
        }
    }
}

struct UserCell: View {
    let user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.name)
                    .fontWeight(.medium)
                Text(user.company)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "circle.fill")
                .font(.footnote)
                .foregroundColor(user.isActive ? .green : .clear)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
