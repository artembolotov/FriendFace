//
//  ContentView.swift
//  FriendFace
//
//  Created by artembolotov on 26.02.2023.
//

import SwiftUI
import CoreData

struct UsersView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var cachedUsers: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cachedUsers) { user in
                    NavigationLink {
                        UserDetailsView(user: user.convertToUser())
                    } label: {
                        UserCell(user: user)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Users")
        }
        .task {
            await DataController.shared.fetchFromNetwork()
        }
    }
}

struct UserCell: View {
    let user: CachedUser
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.nameWrapped)
                    .fontWeight(.medium)
                Text(user.companyWrapped)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Image(systemName: "circle.fill")
                .font(.footnote)
                .foregroundColor(user.isActive ? .green : .clear)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        UsersView()
//            .environment(\.managedObjectContext, DataController().container.viewContext)
//    }
//}
