//
//  UIApplication.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 08/06/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
