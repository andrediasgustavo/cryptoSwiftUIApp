//
//  Settingsview.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 29/06/24.
//

import SwiftUI

struct Settingsview: View {
    
    let youtubeURL = URL(string: "https://www.youtube.com/@SwiftfulThinking")
    let coinGeckoURL = URL(string: "https://www.coingecko.com/")
    let linkedinURL = URL(string: "https://www.linkedin.com/in/andregustavodias/")
    let defaultURL = URL(string: "https://github.com/andrediasgustavo")
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                List {
                    developerSection()
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    swiftfulThinkingSection()
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    coinGeckoSection()
                        .listRowBackground(Color.theme.background.opacity(0.5))
                    applicationSection()
                        .listRowBackground(Color.theme.background.opacity(0.5))
                }
            }
            .font(.headline)
            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

extension Settingsview {
    
    private func swiftfulThinkingSection() -> some View {
        Section(header: Text("Swiftful Thinking")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 25) )
                    .padding(.vertical, 8)
                Text("This map was made by following a @swiftfulthinking course on Youtube. It uses SwiftUI, MVVM, Combine and Core Data.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            if let url = youtubeURL {
                Link("Swiftful Thinking Youtube link", destination: url)
            }
        }
    }
    
    private func coinGeckoSection() -> some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 25) )
                    .padding(.vertical, 8)
                Text("The cryptocurrency data that is used in this app comes from a free api from CoinGecko, prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            if let url = coinGeckoURL {
                Link("CoingGecko link", destination: url)
            }
        }
    }
    
    private func developerSection() -> some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("photo")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 25) )
                    .padding(.vertical, 8)
                Text("This app was made by André Dias, it uses SwiftUI and is written 100% in Swift. The project benefits from multi-threading, observable patterns and data persistence.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color.theme.accent)
            }
            .padding(.vertical)
            if let url = linkedinURL {
                Link("My LinkedIn link", destination: url)
            }
        }
    }
    
    private func applicationSection() -> some View {
        Section(header: Text("Application")) {
            if let url = defaultURL {
                Link("Terms of Service", destination: url)
                Link("Privacy Policy", destination: url)
                Link("Company Website", destination: url)
                Link("Learn More", destination: url)
            }
        }
    }
}

#Preview {
    Settingsview()
}
