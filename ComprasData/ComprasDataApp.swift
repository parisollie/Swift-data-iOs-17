//
//  ComprasDataApp.swift
//  ComprasData
//
//  Created by Paul F on 07/10/24.
//

import SwiftUI
import SwiftData
@main
struct ComprasDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            //Vid 431
                .modelContainer(for: [ListModel.self, ArticulosModel.self])
        }
    }
}
