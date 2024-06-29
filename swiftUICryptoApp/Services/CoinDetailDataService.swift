//
//  CoinDetailDataService.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 26/06/24.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetail: CoinDetailModel?
    private var coinDetailSubscription: AnyCancellable?
    
    init(coin: CoinModel) {
        getCoinDetail(coin: coin)
    }
    
    func getCoinDetail(coin: CoinModel) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion:  NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] coinDetail in
                guard let self = self else { return }
                self.coinDetail = coinDetail
                self.coinDetailSubscription?.cancel()
            })
    }
}

