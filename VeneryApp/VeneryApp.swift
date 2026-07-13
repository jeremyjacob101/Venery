import SwiftUI
import WidgetKit

@main
struct VeneryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    WidgetCenter.shared.reloadTimelines(ofKind: "com.jeremyjacob.Venery.daily-animal")
                }
        }
    }
}
