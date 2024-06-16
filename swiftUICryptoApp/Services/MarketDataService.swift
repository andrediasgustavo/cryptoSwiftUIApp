//
//  MarketDataServices.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 16/06/24.
//


import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    private var marketDataSubscription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] globalData in
                guard let self = self else { return }
                self.marketData = globalData.data
                self.marketDataSubscription?.cancel()
            })
    }
}

