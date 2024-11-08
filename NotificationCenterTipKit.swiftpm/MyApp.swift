import SwiftUI
import TipKit

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NotificationsListView()
                    .task {
                        do {
                            try Tips.resetDatastore()
                            try Tips.configure()
                        } catch {
                            // Handle TipKit errors
                            print("Error initializing TipKit \(error.localizedDescription)")
                        }
                    }
            }
        }
    }
}
