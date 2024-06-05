//
//  CoinImageService.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 04/06/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private var coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: self.coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion:  NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] image in
                guard let self = self else { return }
                self.image = image
                self.imageSubscription?.cancel()
            })
    }
}
