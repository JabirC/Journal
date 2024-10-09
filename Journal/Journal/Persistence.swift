//
//  Persistence.swift
//  Journal
//
//  Created by Jabir Chowdhury on 10/8/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Preview setup for SwiftUI previews
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Add mock data to the preview context
        result.addMockData(context: viewContext)
        
        return result
    }()

    let container: NSPersistentContainer

    // Initialization
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Journal")
        
        // Use in-memory store if requested (for previews or testing)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Load the persistent stores
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this with appropriate error handling for production apps
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true

    }
    
    // Function to add mock data
    private func addMockData(context: NSManagedObjectContext) {
        for i in 1...5 {
            let newEntry = JournalEntry(context: context)
            newEntry.title = "Journal Entry \(i)"
            newEntry.content = "This is the content for journal entry \(i). It's a placeholder to demonstrate mock data."
            newEntry.date = Date().addingTimeInterval(Double(-i * 86400)) // Each entry is one day older
            print("Added Journal Entry \(i)")
        }
        
        do {
            try context.save()
            print("Mock data saved successfully.")
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
