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
    
    @StateObject private var viewModel: DetailViewModel
    @State private var showFullDescription: Bool = false
    private let collumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let spacing: CGFloat = 30
   
    init(coin: CoinModel) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    
                    overviewTitle()
                    Divider()
                    descriptionSection()
                    overViewGrid()
                    additionalTitle()
                    Divider()
                    additionalGrid()
                    websiteSection()
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItems()
            }
        }
    }
}

extension DetailView {
    
    private func navigationBarTrailingItems() -> some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.secondaryText)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private func overviewTitle() -> some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func descriptionSection() -> some View {
        ZStack {
            if let description = viewModel.coinDescription,
               !description.isEmpty {
                VStack(alignment: .leading) {
                    Text(description)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundColor(Color.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .accentColor(.blue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private func additionalTitle() -> some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func overViewGrid() -> some View {
        LazyVGrid(columns: collumns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/,
                  content: {
            ForEach(viewModel.overviewStatistics) { stats in
                StatisticView(stat: stats)
            }
        })
    }
    
    private func additionalGrid() -> some View {
        LazyVGrid(columns: collumns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/,
                  content: {
            ForEach(viewModel.additionalStatistics) { stats in
                StatisticView(stat: stats)
            }
        })
    }
    
    private func websiteSection() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = viewModel.websiteURL,
               let websiteURL = URL(string: websiteString) {
                Link("Website", destination: websiteURL)
            }
            
            if let redditString = viewModel.redditURL,
               let redditURL = URL(string: redditString) {
                Link("Reddit", destination: redditURL)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
    }
}
