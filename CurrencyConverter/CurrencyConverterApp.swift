//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by A101Mac on 20.01.2022.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
