//
//  ContentView.swift
//  Journal
//
//  Created by Jabir Chowdhury on 10/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            JournalView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Journal")
                }
            
            WriteView()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Write")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Profile")
                }
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
