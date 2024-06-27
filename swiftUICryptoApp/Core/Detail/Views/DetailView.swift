//
//  DetailView.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 26/06/24.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
      
    }
}

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
   
    init(coin: CoinModel) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text("Hello")
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.coin)
    }
}
