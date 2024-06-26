//
//  CircleButtonAnimationView.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 01/06/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
            .animation(animate ? Animation.easeInOut(duration: 1.0) : .none)
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(true))
        .foregroundColor(.red)
        .frame(width: 50, height: 50)
}
