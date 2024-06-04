//
//  HomeView.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 01/06/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack {
                homeHeader()
                headerColumn()
                
                if !showPortfolio {
                    allCoinList(coins: viewModel.allCoins)
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioList(coins: viewModel.portfolioCoins)
                        .transition(.move(edge: .trailing))
                }
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
            }
        }
    }
}

extension HomeView {

    private func homeHeader() -> some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background {
                    CircleButtonAnimationView(animate: $showPortfolio)
                }
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? -180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private func allCoinList(coins: [CoinModel]) -> some View {
        setupCoinsList(coins: coins, showHoldingsColumn: false)
    }
    
    private func portfolioList(coins: [CoinModel]) -> some View {
        setupCoinsList(coins: coins, showHoldingsColumn: true)
    }
    
    private func setupCoinsList(coins: [CoinModel], showHoldingsColumn: Bool) -> some View {
        List {
            ForEach(coins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: showHoldingsColumn)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    
    private func headerColumn() -> some View {
        HStack {
            Text("Coins")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}
