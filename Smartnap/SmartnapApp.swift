import SwiftUI

@main
struct SmartnapApp: App {
    @StateObject private var themeSettings = ThemeSettings()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(themeSettings)
        }
    }
}
