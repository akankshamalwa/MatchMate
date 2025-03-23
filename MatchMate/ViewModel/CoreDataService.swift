//
//  CoreDataService.swift
//  MatchMate
//
//  Created by Akanksha Dipak Bothe on 20/03/25.
//

import Foundation
import CoreData

class CoreDataService {
    let context = PersistenceController.shared.container.viewContext
    
    func saveUsers(_ users: [UserProfile]) {
        for user in users {
            let entity = CDUserEntity(context: context)
            entity.id = user.id
            entity.name = user.name
            entity.age = Int16(user.age)
            entity.location = user.location
            entity.imageUrl = user.imageUrl
            entity.status = user.status?.rawValue
        }
        PersistenceController.shared.saveContext()
    }
    
    func loadUsers() -> [UserProfile] {
        let request: NSFetchRequest<CDUserEntity> = CDUserEntity.fetchRequest()
        let result = (try? context.fetch(request)) ?? []
        return result.map {
            UserProfile(
                id: $0.id ?? UUID(),
                name: $0.name ?? "",
                age: Int($0.age),
                location: $0.location ?? "",
                imageUrl: $0.imageUrl ?? "",
                status: MatchStatus(rawValue: $0.status ?? "")
            )
        }
    }
    
    func updateUserStatus(user: UserProfile, status: MatchStatus) {
        let request: NSFetchRequest<CDUserEntity> = CDUserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", user.id as CVarArg)
        if let existingUser = (try? context.fetch(request))?.first {
            existingUser.status = status.rawValue
            try? context.save()
        }
    }
}
