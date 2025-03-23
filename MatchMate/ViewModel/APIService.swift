//
//  APIService.swift
//  MatchMate
//
//  Created by Akanksha Dipak Bothe on 20/03/25.
//

import Foundation
import Alamofire
import Combine

/*
 Handles network requests.
 */
class APIService {
    private let apiURL = "https://randomuser.me/api/?results=10"
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUsers(completion: @escaping ([UserProfile]) -> Void) {
        AF.request(apiURL)
            .publishDecodable(type: UserResponse.self)
            .compactMap { $0.value }
            .map { response in
                response.results.map { apiUser in
                    UserProfile(
                        id: UUID(),
                        name: "\(apiUser.name.first) \(apiUser.name.last)",
                        age: apiUser.dob.age,
                        location: apiUser.location.city,
                        imageUrl: apiUser.picture.large
                    )
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { users in
                completion(users)
            })
            .store(in: &cancellables)
    }
    
    func isNetworkAvailable() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
