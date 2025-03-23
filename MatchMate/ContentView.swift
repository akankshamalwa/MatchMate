//
//  ContentView.swift
//  MatchMate
//
//  Created by Akanksha Dipak Bothe on 19/03/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            MatchListView()
                .foregroundColor(Color.white)
        }
    }
}

#Preview {
    ContentView()
}
