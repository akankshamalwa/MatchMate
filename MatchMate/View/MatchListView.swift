//
//  MatchListView.swift
//  MatchMate
//
//  Created by Akanksha Dipak Bothe on 19/03/25.
//

import SwiftUI

struct MatchListView: View {
    @StateObject var viewModel = MatchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                List(viewModel.users) { user in
                    MatchCardView(
                        user: user,
                        acceptAction: { viewModel.updateUserStatus(user: user, status: .accepted) },
                        declineAction: { viewModel.updateUserStatus(user: user, status: .declined) }
                    )
                }
                .navigationTitle("MatchMate")
                .onAppear {
                    viewModel.fetchUsers()
                }
            }
        }
    }
}

#Preview {
    MatchListView()
}
