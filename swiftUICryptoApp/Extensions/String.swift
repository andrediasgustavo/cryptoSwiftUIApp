//
//  Date.swift
//  swiftUICryptoApp
//
//  Created by Andre Dias on 28/06/24.
//

import Foundation

extension String {

    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
