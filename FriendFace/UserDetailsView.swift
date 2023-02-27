//
//  UserDetails.swift
//  FriendFace
//
//  Created by artembolotov on 27.02.2023.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User
    
    let rows = [GridItem(.adaptive(minimum: 100))]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 15) {
                Group {
                    
                    Text(user.name.components(separatedBy: .whitespaces).joined(separator: "\n"))
                    .font(Font.system(size: 34).bold())
                    
                    Text("\(user.company), \(user.age)")
                        .font(.callout)
                    
                    Text(user.address)
                        
                    Text(user.email)
                        .foregroundColor(.blue)
                    
                    Text(user.about)
                    
                    if let tags = tagsInTextFormat {
                        Text(tags)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                
                if !user.friends.isEmpty {
                    Text("Friends:")
                        .padding(.horizontal)
                        .padding(.bottom, -10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows) {
                            ForEach(user.friends) { friend in
                                Text(
                                    friend.name
                                        .components(separatedBy: .whitespaces)
                                        .joined(separator: "\n")
                                )
                                .foregroundColor(.white)
                                .padding(8)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var tagsInTextFormat: String? {
        guard !user.tags.isEmpty else { return nil }
        
        return user.tags.map { "#\($0)" }.joined(separator: ", ")
    }
}

struct UserDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailsView(user: UsersViewModel.testUser)
        }
    }
}
