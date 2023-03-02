//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by artembolotov on 26.02.2023.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var dataController = DataController.shared
    
    var body: some Scene {
        WindowGroup {
            UsersView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
