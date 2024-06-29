//
//  PortfolioView.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 16/06/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedtCoin: CoinModel? = nil
    @State private var quantityString: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    coinLogoList()
                    
                    if selectedtCoin != nil {
                        portfolioInputSection()
                    }
                }
            }
            .background(
                Color.theme.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    traillingNavBarButton()
                }
            }
            .onChange(of: viewModel.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

extension PortfolioView {
    
    private func coinLogoList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.searchText.isEmpty ? viewModel.portfolioCoins : viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedtCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1.0)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
    
    func updateSelectedCoin(coin: CoinModel) {
        selectedtCoin = coin
        
        if let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id }), let amount = portfolioCoin.currentHoldings {
            quantityString = String(amount)
        } else {
            quantityString = ""
        }
    }
    
    private func portfolioInputSection() -> some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedtCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedtCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Ammount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityString)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text("\(getCurrentValue(quantityText: quantityString, currentPrice: selectedtCoin?.currentPrice ?? 0).asCurrencyWith2Decimals())")
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    
    private func traillingNavBarButton() -> some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                    .font(.headline)
            }
            .opacity(
                (selectedtCoin != nil && selectedtCoin?.currentHoldings != Double(quantityString)) ? 1.0 : 0.0
            )
        }
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedtCoin,
        let amount = Double(quantityString) else { return }
        
        viewModel.updatePorfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedtCoin = nil
        viewModel.searchText = ""
    }
    
    private func getCurrentValue(quantityText: String, currentPrice: Double) -> Double {
        if let quantity = Double(quantityText) {
            return quantity * currentPrice
        }
        return 0
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}
