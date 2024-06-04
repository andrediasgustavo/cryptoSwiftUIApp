//
//  HomeViewModel.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 03/06/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getAllCoins()
    }
    
    private func getAllCoins() {
        dataService.$allCoins.sink { [weak self] coinList in
            guard let self = self else { return }
            self.allCoins.append(contentsOf: coinList)
        }.store(in: &cancellables)
    }
}
