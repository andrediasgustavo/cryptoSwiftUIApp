//
//  XMarkButton.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 16/06/24.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        Button(action: {
            dismiss()
            viewModel.searchText = ""
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
            .environmentObject(dev.homeVM)
    }
    
}
