//
//  MatchViewModel.swift
//  MatchMate
//
//  Created by Akanksha Dipak Bothe on 19/03/25.
//

import Foundation
import Combine
import CoreData
import Alamofire

class MatchViewModel: ObservableObject {
    @Published var users: [UserProfile] = []
    private let apiService = APIService()
    private let coreDataService = CoreDataService()
    
    // Fetches users either from API or Core Data.
    func fetchUsers() {
        if apiService.isNetworkAvailable() {
            apiService.fetchUsers { [weak self] users in
                DispatchQueue.main.async {
                    self?.users = users
                    self?.coreDataService.saveUsers(users)
                }
            }
        } else {
            users = coreDataService.loadUsers()
        }
    }
    
    // Updates user status and persists changes.
    func updateUserStatus(user: UserProfile, status: MatchStatus) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index].status = status
            coreDataService.updateUserStatus(user: users[index], status: status)
        }
    }
}
