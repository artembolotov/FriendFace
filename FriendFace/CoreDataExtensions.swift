//
//  CoreDataExtensions.swift
//  FriendFace
//
//  Created by artembolotov on 28.02.2023.
//

import Foundation
import CoreData

extension CachedUser {
    var idWrapped: String {
        id ?? "Unknown ID"
    }
    
    var nameWrapped: String {
        name ?? "Unknown Name"
    }
    
    var companyWrapped: String {
        company ?? "Unknown Company"
    }
    
    func convertToUser() -> User {
        User(
            id: id ?? "Unknown id",
            isActive: isActive,
            name: nameWrapped,
            age: Int(age),
            company: companyWrapped,
            email: email ?? "Unknown email",
            address: address ?? "Unknown address",
            about: about ?? "Empty about",
            registered: registered ?? Date(),
            tags: tags?.components(separatedBy: ", ") ?? [],
            friends: (friends?.sortedArray(using: [NSSortDescriptor(key: "name", ascending: true)]) as! [CachedFriend]).map { $0.convertToFriend() }
        )
    }
}


extension CachedFriend {
    func convertToFriend() -> Friend {
        Friend(
            id: id ?? "Unknoun Id",
            name: name ?? "Unknown Name"
        )
    }
}
