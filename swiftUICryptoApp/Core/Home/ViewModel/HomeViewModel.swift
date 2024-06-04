//
//  HomeViewModel.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 03/06/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.allCoins.append(DeveloperPreview.instance.coin)
            self?.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
    }
}
