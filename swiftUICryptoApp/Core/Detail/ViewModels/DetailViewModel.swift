//
//  DetailViewModel.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 26/06/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
        
    }
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetail
            .sink { coinDetailModel in
                print(coinDetailModel)
            }.store(in: &cancellables)
    }
    
}
