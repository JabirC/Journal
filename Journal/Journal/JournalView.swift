//
//  JournalView.swift
//  Journal
//
//  Created by Jabir Chowdhury on 10/8/24.
//

import SwiftUI
import CoreData

struct JournalView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
            entity: JournalEntry.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \JournalEntry.date, ascending: false)],
            animation: .default
        ) private var journalEntries: FetchedResults<JournalEntry>
    
    var body: some View {
            List {
                ForEach(journalEntries) { entry in
                    VStack(alignment: .leading) {
                        Text(entry.title ?? "Untitled")
                            .font(.headline)
                        Text(entry.content ?? "No content")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(entry.dateFormatted)
                            .font(.caption)
                            .foregroundColor(.pink)
                    }
                }
            }
            .navigationTitle("Journal Entries")
        }
    // Function to delete an entry from Core Data
    private func deleteEntries(at offsets: IndexSet) {
        for index in offsets {
            let entry = journalEntries[index]
            viewContext.delete(entry)
        }
        saveContext()
    }
        
    // Function to add a new journal entry
    private func addEntry() {
        let newEntry = JournalEntry(context: viewContext)
        newEntry.title = "New Entry"
        newEntry.content = "This is the content of the journal entry."
        newEntry.date = Date()
        saveContext()
    }
        
    // Save the context after adding or deleting entries
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            // Handle the error appropriately in a production app
            print("Failed to save context: \(error.localizedDescription)")
        }
    }

    
}

// JournalEntry Model Extension for Date Formatting
extension JournalEntry {
    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date ?? Date())
    }
}


#Preview {
    JournalView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
