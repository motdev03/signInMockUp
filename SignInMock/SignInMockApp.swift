//
//  SignInMockApp.swift
//  SignInMock
//
//  Created by Tom Manuel on 29/08/24.
//

import SwiftUI
import SwiftData

@main
struct SignInMockApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            SignInView(
                viewModel: SignInViewModel(
                    signInServiceHandler: SignInServiceHandler()
                )
            )
        }
        .modelContainer(sharedModelContainer)
    }
}
