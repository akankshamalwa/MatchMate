//
//  UserProfile.swift
//  MatchMate
//
//  Created by Akanksha Dipak Bothe on 19/03/25.
//

import Foundation

// MARK: - Model

/*
 Represents a user profile with an id, name, age, location, and profile image URL.
 Includes an optional status to track whether the user is accepted or declined.
 */
struct UserProfile: Identifiable, Codable {
    let id: UUID
    let name: String
    let age: Int
    let location: String
    let imageUrl: String
    var status: MatchStatus? = nil
}

/*
 Enum representing the match status of a user.
 */
enum MatchStatus: String, Codable {
    case accepted = "Accepted"
    case declined = "Declined"
}

/*
 Structure representing the API response containing a list of users.
 */
struct UserResponse: Codable {
    let results: [UserModel]
}

/*
 Structure representing an individual user returned from the API.
 */
struct UserModel: Codable {
    let name: Name
    let dob: Dob
    let location: Location
    let picture: Picture
    
    struct Name: Codable {
        let first: String
        let last: String
    }
    
    struct Dob: Codable {
        let age: Int
    }
    
    struct Location: Codable {
        let city: String
    }
    
    struct Picture: Codable {
        let large: String
    }
}
