//
//  CoinRowView.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 02/06/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel 
    var showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumnView()
            Spacer()
            if showHoldingsColumn {
                centerColumnView()
            }
            rightColumnView()
        }
        .font(.subheadline)
        .background(
            Color.theme.background.opacity(0.001)
        )
    }
}

extension CoinRowView {
    
    func leftColumnView() -> some View {
        HStack(spacing: 0) {
            Text(String(coin.rank))
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    func centerColumnView() -> some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accent)
    }
    
    func rightColumnView() -> some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}
