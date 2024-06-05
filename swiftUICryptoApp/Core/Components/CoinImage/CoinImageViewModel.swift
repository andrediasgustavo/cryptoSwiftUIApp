//
//  CoinImageViewModel.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 04/06/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        getImage()
    }
    
    private func getImage() {
        dataService.$image.sink { [weak self] _ in
            self?.isLoading = true
        } receiveValue: { [weak self] image in
            guard let self = self else { return }
            self.image = image
        }.store(in: &cancellables)
    }
}
