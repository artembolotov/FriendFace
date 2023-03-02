//
//  User.swift
//  FriendFace
//
//  Created by artembolotov on 26.02.2023.
//

import Foundation
import CoreData

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    
    let friends: [Friend]
    
    func cacheIn(moc: NSManagedObjectContext) {
        let cachedUser = CachedUser(context: moc)
        
        cachedUser.id = id
        cachedUser.isActive = isActive
        cachedUser.name = name
        cachedUser.age = Int64(age)
        cachedUser.company = company
        cachedUser.email = email
        cachedUser.address = address
        cachedUser.about = about
        cachedUser.registered = registered
        cachedUser.tags = tags.joined(separator: ", ")
        
        friends.forEach { friend in
 
            let cachedFriend = CachedFriend(context: moc)
            
            cachedFriend.id = friend.id
            cachedFriend.name = friend.name
            
            cachedUser.addToFriends(cachedFriend)
        }
    }
}
