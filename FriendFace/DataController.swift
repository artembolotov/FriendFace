//
//  DataController.swift
//  FriendFace
//
//  Created by artembolotov on 27.02.2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    
    let container = NSPersistentContainer(name: "FriendFace")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load persistant store: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
    @MainActor
    func fetchFromNetwork() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let users = try decoder.decode([User].self, from: data)
            
            
            let context = container.viewContext
            
            users.forEach { user in
                user.cacheIn(moc: context)
            }
            
            if context.hasChanges {
                try context.save()
            }
            
            
        } catch {
            print("Could not fetch data. \(error)")
        }
        
    }
}
