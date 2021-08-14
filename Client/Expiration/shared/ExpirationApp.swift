//
//  ExpirationApp.swift
//  Expiration
//
//  Created by 조종운 on 2021/05/12.
//

import SwiftUI

@main
struct ExpirationApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
