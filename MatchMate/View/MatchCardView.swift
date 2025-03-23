//
//  MatchCardView.swift
//  MatchMate
//
//  Created by Akanksha Dipak Bothe on 19/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

/*
 A SwiftUI view representing a match card for a user profile.
 Displays the user's image, name, age, location, and status.
 Provides buttons to accept or decline the match.
 */
struct MatchCardView: View {
    let user: UserProfile
    var acceptAction: () -> Void
    var declineAction: () -> Void
    
    var body: some View {
        VStack {
            profileImageView
            userInfoView
            statusOrActionButtons
        }
        .frame(width: 250, height: 300)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding()
    }
    
    // MARK: - Profile Image View
    private var profileImageView: some View {
        WebImage(url: URL(string: user.imageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .shadow(radius: 5)
            .padding()
    }
    
    // MARK: - User Info View
    private var userInfoView: some View {
        VStack {
            Text(user.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            
            Text("\(user.age), \(user.location)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
    
    // MARK: - Status or Action Buttons View
    private var statusOrActionButtons: some View {
        HStack {
            if user.status == .accepted {
                statusTextView(text: "Accepted", color: .green)
            } else if user.status == .declined {
                statusTextView(text: "Declined", color: .red)
            } else {
                acceptDeclineButtons
            }
        }
    }
    
    // MARK: - Status Text View
    private func statusTextView(text: String, color: Color) -> some View {
        Text(text)
            .frame(width: 150, height: 30)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding()
    }
    
    // MARK: - Accept/Decline Buttons View
    private var acceptDeclineButtons: some View {
        HStack {
            actionButtonView(imageName: "checkmark.circle.fill", color: .green, action: acceptAction)
            actionButtonView(imageName: "xmark.circle.fill", color: .red, action: declineAction)
        }
    }
    
    private func actionButtonView(imageName: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(color)
        }
        .buttonStyle(PlainButtonStyle())
        .padding()
    }
}

#Preview {
    MatchCardView(
        user: UserProfile(
            id: UUID(),
            name: "John Doe",
            age: 30,
            location: "New York",
            imageUrl: "https://via.placeholder.com/100",
            status: nil
        ),
        acceptAction: {},
        declineAction: {}
    )
}
