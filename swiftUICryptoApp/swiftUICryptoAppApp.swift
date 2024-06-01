//
//  swiftUICryptoAppApp.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 01/06/24.
//

import SwiftUI

@main
struct swiftUICryptoAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
